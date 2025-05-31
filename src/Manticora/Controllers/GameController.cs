using Manticora.Data;
using Manticora.Models;
using Manticora.Patterns;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;

namespace Manticora.Controllers
{
    public class GameController : Controller
    {
        private readonly DataContext _context;
        private readonly IHttpClientFactory _http;
        private readonly IConfiguration _configuration;

        private static readonly Random _random = new();

        public GameController(DataContext context, IHttpClientFactory http, IConfiguration configuration)
        {
            _context = context;
            _http = http;
            _configuration = configuration;
        }

        [HttpGet]
        public async Task<IActionResult> Start()
        {
            var defenders = await _context.Characters
                .Include(c => c.Inventory).ThenInclude(i => i.Weapon)
                .Where(c => c.Selected)
                .Take(2).ToListAsync();

            var location = await GetRandomLocation();

            var game = new GameState
            {
                CityHealth = 15,
                ManticoreHealth = 10,
                Location = location,
                Defenders = defenders
            };

            _context.GameStates.Add(game);
            await _context.SaveChangesAsync();

            TempData["GameId"] = game.Id;

            return RedirectToAction("Play");
        }

        [HttpGet]
        public async Task<IActionResult> Play()
        {
            var gameId = (int)TempData["GameId"];
            var game = await _context.GameStates
                .Include(g => g.Location)
                .Include(g => g.Defenders).ThenInclude(d => d.Inventory).ThenInclude(i => i.Weapon)
                .FirstOrDefaultAsync(g => g.Id == gameId);

            var log = new List<string>();
            int previousPosition = 0;

            foreach (var round in Enumerable.Range(1, 5))
            {
                foreach (var defender in game.Defenders)
                {
                    var item = defender.Inventory.FirstOrDefault(i => i.ShotsLeft > 0);
                    if (item == null) continue;

                    int position;
                    do
                    {
                        position = _random.Next(1, 6) * 10;
                    } while (position == previousPosition);
                    previousPosition = position;

                    var range = item.Weapon.Range;
                    item.ShotsLeft--;

                    //string result;
                    //int manticoreDamage = 0, cityDamage = 0;
                    //Strategy pattern applied
                    var strategyContext = new DamageStrategyContext();
                    strategyContext.ChooseStrategy(range, position);
                    (var manticoreDamage, var cityDamage, var result) = strategyContext.ExecuteStrategy(range, position);

                    if (range < position)
                    {
                        cityDamage = 5;
                        result = "Corto";
                    }
                    else if (range == position)
                    {
                        manticoreDamage = 5;
                        result = "Directo";
                    }
                    else
                    {
                        manticoreDamage = 2;
                        cityDamage = 1;
                        result = "Largo";
                    }

                    defender.DamageDealt += manticoreDamage;
                    game.CityHealth -= cityDamage;
                    game.ManticoreHealth -= manticoreDamage;

                    log.Add($"STATUS: Ronda: {round} Ciudad: {game.CityHealth}/15 Mantícora: {game.ManticoreHealth}/10 Disparo: {item.ShotsLeft}/5\n" +
                            $"La Mantícora está a una distancia de {position}, el ataque con {item.Weapon.Name} cubre {range} y fue un tiro {result}\n" +
                            $"Ciudad recibió {cityDamage} daño, Mantícora recibió {manticoreDamage} daño");

                    if (game.CityHealth <= 0 || game.ManticoreHealth <= 0) break;
                }

                if (game.CityHealth <= 0 || game.ManticoreHealth <= 0) break;
            }

            await _context.SaveChangesAsync();

            ViewBag.Log = log;
            ViewBag.GameOver = true;
            return View(game);
        }

        [HttpPost]
        public async Task<IActionResult> EndGame()
        {
            var characters = await _context.Characters
                                           .Where(c => c.Selected)
                                           .ToListAsync();

            if (characters != null && characters.Any())
            {
                foreach (var c in characters)
                {
                    c.Selected = false;
                    _context.Update(c);
                }
                await _context.SaveChangesAsync();
            }

            return RedirectToAction("Index", "Characters");
        }

        private async Task<Location> GetRandomLocation()
        {
            var apiUrl = _configuration["Api:UrlRoot"];

            var client = _http.CreateClient();
            var locJson = JObject.Parse(await client.GetStringAsync($"{apiUrl}/location"));
            var count = (int)locJson["info"]["count"];
            int randomId = _random.Next(1, count + 1);

            var response = await client.GetStringAsync($"{apiUrl}/location/{randomId}");
            var json = JObject.Parse(response);

            return new Location
            {
                Name = (string)json["name"],
                Type = (string)json["type"],
                Dimension = (string)json["dimension"],
                Residents = ((JArray)json["residents"]).Count
            };
        }
    }
}
