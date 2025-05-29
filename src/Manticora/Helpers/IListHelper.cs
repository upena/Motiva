using Manticora.Models;

namespace Manticora.Helpers
{
    public interface IListHelper
    {
        Task<List<Weapon>> GetWeaponsAsync();
    }
}
