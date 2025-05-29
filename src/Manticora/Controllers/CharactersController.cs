using Manticora.Data;
using Manticora.Helpers;
using Manticora.Models;
using Manticora.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;

namespace Manticora.Controllers
{
    public class CharactersController : Controller
    {
        private readonly DataContext _context;
        private readonly IHttpClientFactory _clientFactory;
        private readonly ICacheService _cacheService;
        private readonly IConfiguration _configuration;
        private readonly IListHelper _listHelper;

        public CharactersController(DataContext context, 
                        IHttpClientFactory clientFactory,
                        ICacheService cacheService,
                        IConfiguration configuration,
                        IListHelper listHelper)
        {
            _context = context;
            _clientFactory = clientFactory;
            _cacheService = cacheService;
            _configuration = configuration;
            _listHelper = listHelper;
        }

        private async Task<CharactersInfo> GetCharacters(string? name, int page, string? selected)
        {
            var characters = await _cacheService.GetCharactersInfoAsync(name, page, selected);

            return characters;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var selectedCharacters = await _context.Characters
                                         .Where(c => c.Selected)
                                         .Select(c => c.Id)
                                         .ToListAsync();

            string? _selected = null;

            if (selectedCharacters != null && selectedCharacters.Any())
                _selected = string.Join(",", selectedCharacters);
            var characters = await GetCharacters(null, 1, _selected);
            characters.Info.SelectedCharacters = _selected;

            return View(characters);
        }

        [HttpGet]
        public async Task<IActionResult> GetCharactersPartial(string? name, int page, string? selected)
        {
            var characters = await GetCharacters(name, page, selected);
            return PartialView("Characters/_CharactersList", characters);
        }

        [HttpGet]
        public async Task<IActionResult> GetCharacterDetails(int id)
        {
            var character = await _cacheService.GetCharacterAsync(id);
            return PartialView("Characters/_CharacterDetails", character);
        }

        [HttpPost]
        public async Task<JsonResult> SelectCharacter(bool selected, int id)
        {
            try
            {
                var apiUrl = $"{_configuration["Api:UrlRoot"]}/character/{id}";
                var client = _clientFactory.CreateClient();
                var response = await client.GetStringAsync(apiUrl);
                var json = JObject.Parse(response);

                var character = new Character();
                character = await _context.Characters.FindAsync(id);
                bool isNewCharacterDB = false;

                if (character == null)
                {
                    character = new Character();
                    isNewCharacterDB = true;
                }

                character.Id = (int)json["id"];
                character.Name = (string)json["name"];
                character.Species = (string)json["species"];
                character.Type = (string)json["type"];
                character.Gender = (string)json["gender"];
                character.ImageUrl = (string)json["image"];
                character.Gold = 100;
                character.Selected = selected;

                if (isNewCharacterDB)
                    await _context.Characters.AddAsync(character);
                else
                    _context.Characters.Update(character);
                await _context.SaveChangesAsync();

                return Json(new { isSuccess = true });
            }
            catch(Exception ex)
            {
                return Json(new { isSuccess = false, message = $"{ex.Message} : {ex.InnerException?.Message}" });
            }
        }

        [HttpGet]
        public async Task<IActionResult> EquipCharacter(int id)
        {
            var character = await _context.Characters
               .Include(c => c.Inventory)
               .ThenInclude(i => i.Weapon)
               .FirstOrDefaultAsync(c => c.Id == id);

            var characterEquip = new CharacterEquip();
            characterEquip.Id = character.Id;
            characterEquip.Name = character.Name;
            characterEquip.Species = character.Species;
            characterEquip.Type = character.Type;
            characterEquip.Gender = character.Gender;
            characterEquip.ImageUrl = character.ImageUrl;
            characterEquip.Inventory = character.Inventory;
            characterEquip.DamageDealt = character.DamageDealt;
            characterEquip.Gold = character.Gold;
            characterEquip.Selected = character.Selected;
            characterEquip.Weapons = await _listHelper.GetWeaponsAsync();

            return PartialView("Characters/_Shop", characterEquip);
        }

        [HttpPost]
        public async Task<IActionResult> Buy(int characterId, int weaponId)
        {
            var character = await _context.Characters.FindAsync(characterId);
            var weapon = await _context.Weapons.FindAsync(weaponId);

            if (character.Gold >= weapon.Cost)
            {
                character.Gold -= weapon.Cost;
                _context.InventoryItems.Add(new InventoryItem
                {
                    CharacterId = characterId,
                    WeaponId = weaponId
                });

                await _context.SaveChangesAsync();
            }

            var inventory = await _context.InventoryItems.Include(i => i.Weapon)
                                          .Where(i => i.CharacterId == characterId)
                                          .ToListAsync();
            var characterEquip = new CharacterEquip();
            characterEquip.Gold = character.Gold;
            characterEquip.Inventory = inventory;

            return PartialView("Characters/_Inventory", characterEquip);
        }

        public async Task<IActionResult> Select(int id)
        {
            var client = _clientFactory.CreateClient();
            var response = await client.GetStringAsync($"https://rickandmortyapi.com/api/character/{id}");
            var json = JObject.Parse(response);

            var character = new Character
            {
                Id = (int)json["id"],
                Name = (string)json["name"],
                Species = (string)json["species"],
                Type = (string)json["type"],
                Gender = (string)json["gender"],
                ImageUrl = (string)json["image"],
                Gold = 100
            };

            _context.Characters.Add(character);
            await _context.SaveChangesAsync();

            return RedirectToAction("Equip", "Shop", new { id = character.Id });
        }
    }
}
