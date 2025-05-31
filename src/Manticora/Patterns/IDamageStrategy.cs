namespace Manticora.Patterns
{
    public interface IDamageStrategy
    {
        (int manticoreDamage, int cityDamage, string shotType) CalculateDamage(int weaponRange, int targetDistance);
    }
}
