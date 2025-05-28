namespace Manticora.Models
{
    public class Character
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Species { get; set; }
        public string Type { get; set; }
        public string Gender { get; set; }
        public string ImageUrl { get; set; }
        public int Gold { get; set; } = 100;
        public List<InventoryItem> Inventory { get; set; } = new();
        public int DamageDealt { get; set; } = 0;
    }
}
