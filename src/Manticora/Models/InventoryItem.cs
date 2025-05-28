namespace Manticora.Models
{
    public class InventoryItem
    {
        public int Id { get; set; }
        public int CharacterId { get; set; }
        public Character Character { get; set; }

        public int WeaponId { get; set; }
        public Weapon Weapon { get; set; }

        public int ShotsLeft { get; set; } = 5;
    }

}
