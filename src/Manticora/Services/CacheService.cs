using Manticora.Data;
using Manticora.Models;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json.Linq;

namespace Manticora.Services
{
    public class CacheService: ICacheService
    {
        private readonly IMemoryCache _cache;
        private readonly IHttpClientFactory _clientFactory;
        private readonly IConfiguration _configuration;

        public CacheService(IMemoryCache cache, IHttpClientFactory clientFactory, IConfiguration configuration)
        {
            _cache = cache;
            _clientFactory = clientFactory;
            _configuration = configuration;
        }

        public async Task<Character> GetCharacterAsync(int id)
        {
            var cacheKey = $"characterDetails_{id}";

            if (_cache.TryGetValue(cacheKey, out Character characterDetails))
                return characterDetails;

            var apiUrl = $"{_configuration["Api:UrlRoot"]}/character/{id}";

            var client = _clientFactory.CreateClient();
            var response = await client.GetStringAsync(apiUrl);
            var json = JObject.Parse(response);

            var character = new Character
            {
                Id = (int)json["id"],
                Name = (string)json["name"],
                Species = (string)json["species"],
                Type = (string)json["type"],
                Gender = (string)json["gender"],
                ImageUrl = (string)json["image"]
            };

            _cache.Set(cacheKey, response, TimeSpan.FromMinutes(10));

            return character;
        }

        public async Task<CharactersInfo> GetCharactersInfoAsync(string? name, int page = 1, string? selected = null)
        {
            List<int> selectedIds = new List<int>();
            
            if (!string.IsNullOrWhiteSpace(selected))
                selectedIds = selected.Split(',').Select(int.Parse).ToList();

            if (_cache.TryGetValue("selectedIds", out string selectedIdsCache))
            {
                if (selected != selectedIdsCache)
                    _cache.Remove("characters");
            }
            if (_cache.TryGetValue("name", out string nameCache))
            {
                if (name != nameCache)
                    _cache.Remove("characters");
            }
            if (_cache.TryGetValue("page", out int pageCache))
            {
                if (page != pageCache)
                    _cache.Remove("characters");
            }

            if (_cache.TryGetValue("characters", out CharactersInfo charactersInfo))
                return charactersInfo;

            var apiUrl = $"{_configuration["Api:UrlRoot"]}/character?page={page}";
            if (!string.IsNullOrWhiteSpace(name))
                apiUrl = $"{_configuration["Api:UrlRoot"]}/character?name={name}&page={page}";

            var client = _clientFactory.CreateClient();
            var response = await client.GetFromJsonAsync<CharactersInfo>(apiUrl);

            charactersInfo = response ?? new CharactersInfo();
            if (charactersInfo.Results != null && charactersInfo.Results.Any())
                charactersInfo.Results.ForEach(r => r.Selected = selectedIds.Any(x => x == r.Id));

            _cache.Set("selectedIds", selected, TimeSpan.FromMinutes(10));
            _cache.Set("name", name, TimeSpan.FromMinutes(10));
            _cache.Set("page", page, TimeSpan.FromMinutes(10));
            _cache.Set("characters", charactersInfo, TimeSpan.FromMinutes(10));

            //Set current page
            charactersInfo.Info.CurrentPage = page;
            return charactersInfo;
        }
    }
}
