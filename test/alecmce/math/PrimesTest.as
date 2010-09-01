package alecmce.math
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;
	public class PrimesTest
	{
		private var primes:Primes;
		
		[Before]
		public function before():void
		{
			primes = new Primes();
		}
		
		[After]
		public function after():void
		{
			primes = null;
		}
		
		[Test]
		public function test_isPrime():void
		{
			assertTrue(primes.isPrime(7919));
			assertFalse(primes.isPrime(100000));
		}
		
		[Test]
		public function test_prime_factors():void
		{
			var factors:Vector.<uint> = primes.primeFactors(30);
			assertEquals(3, factors.length);			assertEquals(2, factors[0]);
			assertEquals(3, factors[1]);			assertEquals(5, factors[2]);
		}
		
		[Test]
		public function test_factors_and_resolve_roundtrip():void
		{
			var factors:Vector.<uint> = primes.primeFactors(30);
			assertEquals(30, primes.resolve(factors));
		}
		
		[Test]
		public function highest_common_factors():void
		{
			var hcf:Vector.<uint> = primes.highestCommonFactor(Vector.<uint>([30,50]));
			assertEquals(2, hcf.length);
			assertEquals(2, hcf[0]);
			assertEquals(5, hcf[1]);
		}
		
		[Test]
		public function lowest_common_multiple():void
		{
			var lcm:Vector.<uint> = primes.lowestCommonMultiple(Vector.<uint>([15, 18]));
			assertEquals(4, lcm.length);			assertEquals(2, lcm[0]);			assertEquals(3, lcm[1]);			assertEquals(3, lcm[2]);			assertEquals(5, lcm[3]);
		}
		
	}
}
