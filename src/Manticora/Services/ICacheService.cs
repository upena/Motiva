using Manticora.Models;

namespace Manticora.Services
{
    public interface ICacheService
    {
        Task<CharactersInfo> GetCharactersInfoAsync(string? name, int page = 1);

        Task<Character> GetCharacterAsync(int id);
    }
}
