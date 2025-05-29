using Manticora.Data;
using Manticora.Models;
using Manticora.Services;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;

namespace Manticora.Controllers
{
    public class CharactersController : Controller
    {
        private readonly DataContext _context;
        private readonly IHttpClientFactory _clientFactory;
        private readonly ICacheService _cacheService;

        public CharactersController(DataContext context, 
                        IHttpClientFactory clientFactory,
                        ICacheService cacheService)
        {
            _context = context;
            _clientFactory = clientFactory;
            _cacheService = cacheService;
        }

        private async Task<CharactersInfo> GetCharacters(string? name, int page)
        {
            var characters = await _cacheService.GetCharactersInfoAsync(name, page);

            return characters;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var characters = await GetCharacters(null, 1);

            return View(characters);
        }

        [HttpGet]
        public async Task<IActionResult> GetCharactersPartial(string? name, int page)
        {
            var characters = await GetCharacters(name, page);
            return PartialView("Characters/_CharactersList", characters);
        }

        [HttpGet]
        public async Task<IActionResult> GetCharacterDetails(int id)
        {
            var character = await _cacheService.GetCharacterAsync(id);
            return PartialView("Characters/_CharacterDetails", character);
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
