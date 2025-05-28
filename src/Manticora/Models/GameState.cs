namespace Manticora.Models
{
    public class GameState
    {
        public int Id { get; set; }

        public int CityHealth { get; set; } = 15;
        public int ManticoreHealth { get; set; } = 10;
        public int Round { get; set; } = 1;

        public int? LocationId { get; set; }
        public Location Location { get; set; }

        public List<Character> Defenders { get; set; } = new();
    }

}
