package alecmce.math
{
	/**
	 * Defines a set of functions for retrieving prime numbers, testing
	 * primality, deriving prime factors, lowest common denominators and highest
	 * common multiples.
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class Primes
	{
		// the lowest integer greater than 1/6 of the highest prime, used to
		// shortcut the prime-number mechanism
		private var testMultiplier:int = 166;

		private var list:Vector.<uint> = Vector.<uint>([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 27, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]);

		/**
		 * get the ith prime number
		 */
		public function prime(i:int):uint
		{
			if (i < list.length)
				return list[i];

			var n:int;

			do
			{
				n = 6 * ++testMultiplier;

				if (isPrime(n - 1))
					list.push(n - 1);
				if (isPrime(n + 1))
					list.push(n + 1);
			}
			while (list.length <= i);

			return list[i];
		}

		/**
		 * given a vector of prime factors, return the number they define
		 */
		public function resolve(arr:Vector.<uint>):uint
		{
			var i:uint;
			var n:uint;

			i = 1;
			for each (n in arr)
				i *= n;

			return i;
		}

		/**
		 * determine whether a particular number is prime
		 */
		public function isPrime(i:int):Boolean
		{
			var n:int;
			var len:int = list.length;
			var prime:int;

			n = 2;
			do
			{
				prime = list[n];
				if (i % prime == 0)
					return false;
			}
			while (++n < len && i < (prime >> 1));

			return true;
		}

		/**
		 * get the prime factors for a given number
		 */
		public function primeFactors(i:int):Vector.<uint>
		{
			var n:int = 0;
			var len:int = list.length;
			var factors:Vector.<uint> = new Vector.<uint>();
			var prime:int;

			do
			{
				prime = list[n];
				if (i % prime == 0)
				{
					factors.push(prime);
					i /= prime;
				}
				else
				{
					n++;
				}
			}
			while (n < len && prime <= (i >> 1));

			if (i > 1)
				factors.push(i);

			return factors;
		}

		/**
		 * calculate the highestCommonFactor for n primes
		 *
		 * @param list A vector of numbers for which the highest common factor
		 * is sought
		 * @return A vector of prime factors that expresses the
		 * highest common factor of those numbers
		 */
		public function highestCommonFactor(list:Vector.<uint>):Vector.<uint>
		{
			var factors:Vector.<Vector.<uint>>;
			var i:uint = list.length;

			factors = new Vector.<Vector.<uint>>(i, true);
			while (i--)
				factors[i] = primeFactors(list[i]);

			return intersection(factors);
		}

		/**
		 * calculate the lowestCommonMultiple for n primes
		 *
		 * @param list A vector of numbers for which the lowest common multiple
		 * is sought
		 * @return A vector of prime factors that expresses the
		 * lowest common multpile of those numbers
		 */
		public function lowestCommonMultiple(list:Vector.<uint>):Vector.<uint>
		{
			var factors:Vector.<Vector.<uint>>;
			var i:uint = list.length;

			factors = new Vector.<Vector.<uint>>(i, true);
			while (i--)
				factors[i] = primeFactors(list[i]);

			return union(factors);
		}

		private function intersection(factors:Vector.<Vector.<uint>>):Vector.<uint>
		{
			var i:int;
			var len:uint = factors.length;
			var copy:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
			var working:Vector.<uint> = new Vector.<uint>();

			for (i = 0; i < len; i++)
			{
				var tmp:Vector.<uint> = factors[i].concat();
				working.push(tmp.shift());
				copy.push(tmp);
			}

			var results:Vector.<uint> = new Vector.<uint>();

			while (len)
			{
				i = len;
				var minIndex:int = --i;
				var minValue:int = working[minIndex];
				var areSame:Boolean = true;
				while (i--)
				{
					if (working[i] != minValue)
					{
						areSame = false;
						if (working[i] < minValue)
						{
							minValue = working[i];
							minIndex = i;
						}
					}
				}

				if (areSame)
				{
					results.push(minValue);

					i = len;
					while (copy.length && i--)
					{
						if (copy[i].length)
						{
							working[i] = copy[i].shift();
						}
						else
						{
							copy.splice(i, 1);
							working.splice(i, 1);
							--len;
							++i;
						}
					}
				}
				else
				{
					if (copy[minIndex].length)
					{
						working[minIndex] = copy[minIndex].shift();
					}
					else
					{
						copy.splice(minIndex, 1);
						working.splice(minIndex, 1);
						--len;
					}
				}
			}

			return results;
		}

		/**
		 * assume the factors come in sorted!
		 */
		private function union(factors:Vector.<Vector.<uint>>):Vector.<uint>
		{
			var i:int;
			var len:uint = factors.length;
			var copy:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
			var working:Vector.<uint> = new Vector.<uint>();

			for (i = 0; i < len; i++)
			{
				var tmp:Vector.<uint> = factors[i].concat();
				working.push(tmp.shift());
				copy.push(tmp);
			}

			var results:Vector.<uint> = new Vector.<uint>();

			while (len)
			{
				i = len;
				var minIndex:int = --i;
				var minValue:int = working[minIndex];
				var areSame:Boolean = true;
				while (i--)
				{
					if (working[i] != minValue)
					{
						areSame = false;
						if (working[i] < minValue)
						{
							minValue = working[i];
							minIndex = i;
						}
					}
				}

				results.push(minValue);

				if (areSame)
				{
					i = len;
					while (copy.length && i--)
					{
						if (copy[i].length)
						{
							working[i] = copy[i].shift();
						}
						else
						{
							copy.splice(i, 1);
							working.splice(i, 1);
							--len;
							++i;
						}
					}
				}
				else
				{
					if (copy[minIndex].length)
					{
						working[minIndex] = copy[minIndex].shift();
					}
					else
					{
						copy.splice(minIndex, 1);						working.splice(minIndex, 1);
						--len;					}
				}
			}

			return results;
		}

		private function sortMethod(a:uint, b:uint):int
		{
			return a < b ? -1 : a > b ? 1 : 0;
		}

	}
}
