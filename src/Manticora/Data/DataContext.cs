﻿using Manticora.Models;
using Microsoft.EntityFrameworkCore;

namespace Manticora.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) 
            : base(options)
        {
        }

        public DbSet<Character> Characters { get; set; }
        public DbSet<Weapon> Weapons { get; set; }
        public DbSet<InventoryItem> InventoryItems { get; set; }
        public DbSet<GameState> GameStates { get; set; }
        public DbSet<Location> Locations { get; set; }

        
    }

}
