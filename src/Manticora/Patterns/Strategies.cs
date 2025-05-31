namespace Manticora.Patterns
{
    public class ShortShotStrategy : IDamageStrategy
    {
        public (int, int, string) CalculateDamage(int weaponRange, int targetDistance)
        {
            return (0, 5, "Corto");
        }
    }

    public class DirectShotStrategy : IDamageStrategy
    {
        public (int, int, string) CalculateDamage(int weaponRange, int targetDistance)
        {
            return (5, 0, "Directo");
        }
    }

    public class LongShotStrategy : IDamageStrategy
    {
        public (int, int, string) CalculateDamage(int weaponRange, int targetDistance)
        {
            return (2, 1, "Largo");
        }
    }
}
