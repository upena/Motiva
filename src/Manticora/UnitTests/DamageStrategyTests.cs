using Manticora.Patterns;
using Xunit;

namespace Manticora.UnitTests
{
    //Menu Test --> Run all tests
    public class DamageStrategy : IDamageStrategy
    {
        public (int manticoreDamage, int cityDamage, string shotType) CalculateDamage(int weaponRange, int manticoreDistance)
        {
            if (weaponRange < manticoreDistance)
                return (0, 5, "Corto");

            if (weaponRange > manticoreDistance)
                return (2, 1, "Largo");

            return (5, 0, "Directo");
        }
    }

    public class DamageStrategyTests
    {
        private readonly DamageStrategy _strategy;

        public DamageStrategyTests()
        {
            _strategy = new DamageStrategy();
        }

        [Fact]
        public void Disparo_Corto_Deberia_Danhar_Ciudad()
        {
            var (manticore, city, type) = _strategy.CalculateDamage(20, 40);

            Assert.Equal(0, manticore);
            Assert.Equal(5, city);
            Assert.Equal("Corto", type);
        }

        [Fact]
        public void Disparo_Largo_Deberia_Danhar_Ambos()
        {
            var (manticore, city, type) = _strategy.CalculateDamage(40, 20);

            Assert.Equal(2, manticore);
            Assert.Equal(1, city);
            Assert.Equal("Largo", type);
        }

        [Fact]
        public void Disparo_Directo_Deberia_Danhar_Solo_Manticora()
        {
            var (manticore, city, type) = _strategy.CalculateDamage(30, 30);

            Assert.Equal(5, manticore);
            Assert.Equal(0, city);
            Assert.Equal("Directo", type);
        }
    }
}
