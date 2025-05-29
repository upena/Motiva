using Manticora.Data;
using Manticora.Models;
using Microsoft.EntityFrameworkCore;

namespace Manticora.Helpers
{
    public class ListHelper: IListHelper
    {
        private readonly DataContext _context;

        public ListHelper(DataContext context)
        {
            _context = context;
        }

        public async Task<List<Weapon>> GetWeaponsAsync()
        {
            if (!_context.Weapons.Any())
            {
                _context.Weapons.AddRange(
                    new Weapon { Name = "Gran cañón", Cost = 80, Range = 50 },
                    new Weapon { Name = "Metralla", Cost = 60, Range = 40 },
                    new Weapon { Name = "Mosquete", Cost = 50, Range = 30 },
                    new Weapon { Name = "Pistola", Cost = 30, Range = 20 },
                    new Weapon { Name = "Granada", Cost = 10, Range = 10 }
                );
                await _context.SaveChangesAsync();
            }

           return await _context.Weapons.ToListAsync();
        }
    }
}
