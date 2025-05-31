namespace Manticora.Patterns
{
    public class DamageStrategyContext
    {
        private IDamageStrategy _strategy;

        public void SetStrategy(IDamageStrategy strategy)
        {
            _strategy = strategy;
        }

        public (int manticoreDamage, int cityDamage, string shotType) ExecuteStrategy(int weaponRange, int distance)
        {
            return _strategy.CalculateDamage(weaponRange, distance);
        }

        public void ChooseStrategy(int weaponRange, int distance)
        {
            if (weaponRange < distance)
                SetStrategy(new ShortShotStrategy());
            else if (weaponRange == distance)
                SetStrategy(new DirectShotStrategy());
            else
                SetStrategy(new LongShotStrategy());
        }
    }
}
