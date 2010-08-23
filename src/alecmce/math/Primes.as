package alecmce.math
{
	
	public class Primes
	{
		private var testMultiplier:int = 166;
		// since all primes not on the list must be

		private var list:Vector.<uint> = ([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 27, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]);

		public function prime(i:int):int
		{
			if (i < list.length)
				return list[i];

			var n:int;

			do
			{
				testMultiplier++;
				n = 6 * testMultiplier;

				if (isPrime(n - 1))
					list.push(n - 1);
				if (isPrime(n + 1))
					list.push(n + 1);
			}
			while (list.length <= i);

			return list[i];
		}

		public function indexOf(prime:int):int
		{
			return list.indexOf(prime);
		}

		public function resolve(arr:Vector.<uint>):uint
		{
			var i:uint;
			var n:uint;

			i = 1;
			for each (n in arr)
				i *= n;
			
			return i;
		}

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

		// get the prime factors of each element
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

		public function highestCommonFactor(args:Vector.<uint>):Vector.<uint>
		{
			var factors:Vector.<Vector.<uint>>;
			var i:uint = args.length;

			factors = new Vector.<Vector.<uint>>(i, true);
			while (i--)
				factors[i] = primeFactors(i);

			return intersection(factors);
		}

		public function lowestCommonMultiple(args:Vector.<uint>):Vector.<uint>
		{
			var factors:Vector.<Vector.<uint>>;
			var i:uint = args.length;

			factors = new Vector.<Vector.<uint>>(i, true);
			while (i--)
				factors[i] = primeFactors(i);

			return union(factors);
		}

		private function intersection(factors:Vector.<Vector.<uint>>):Vector.<uint>
		{
			var results:Vector.<uint>;
			var value:uint;
			var i:int;
			var min:uint;
			var minindex:uint;
			var factor:uint;
			var flag:Boolean;
			var finished:Boolean;

			var len:int = factors.length;

			i = len;
			while (i--)
				factors[i] = factors[i].concat().sort(sortMethod);

			results = new Vector.<uint>();
			finished = false;
			do
			{
				// look at the working values - if they're all equal then add
				// that to results flag tests for parity across working's
				// values, min keeps a tab on the lowest value for comparison
				// and minindex stores where it is
				i = len;
				value = factors[--i][0];
				min = value;
				minindex = 0;
				flag = true;
				
				while (i--)
				{
					factor = factors[i][0];
					flag &&= factor == value;
					
					if (factor >= min)
						continue;
					
					min = factor;
					minindex = i;
				}

				// if flag is true then they're all equal so add it to the
				// results and remove the whole line of factors
				if (flag)
				{
					results.push(value);
					
					i = len;
					while (i--)
						factors[i].shift();
				}
				
				// otherwise remove the smallest one - if run out of factors on
				// one of the arrays then there can't be any more intersection
				// so flag finished to break the loop.
				else
				{
					value = factors[minindex].shift();
					if (factors[minindex].length == 0)
						finished = true;
				}
			}
			while (!finished);

			return results;
		}

		private function union(factors:Vector.<Vector.<uint>>):Vector.<uint>
		{
			var results:Vector.<uint>;
			var value:uint;
			var test:uint;
			var i:int;
			var finished:Boolean;
			var len:int = factors.length;

			i = len;
			while (i--)
				factors[i] = factors[i].concat().sort(sortMethod);

			results = new Vector.<uint>();
			finished = false;
			do
			{
				i = len;
				
				// choose the first working value
				value = factors[--i].shift();

				// try to match value against each value in working. When found,
				// remove and replace that value with another ahead of the next
				// round of matchings. When an array is consumed splice it out
				// and continue
				while (i--)
				{
					test = factors[i][0];
					if (test == value)
					{
						if (factors[i].length == 1)
						{
							factors.splice(i, 1);
							--len;
						}
						else
						{
							factors[i].shift();
							++i;
						}
					}
					else
					{
						i++;
					}

				}

				results.push(value);
			}
			while (len > 0);

			return results;
		}
		
		private function sortMethod(a:uint, b:uint):int
		{
			return a < b ? -1 : a > b ? 1 : 0;
		}

	}
}
