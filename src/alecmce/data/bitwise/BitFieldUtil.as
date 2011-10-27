package alecmce.data.bitwise
{

	public class BitFieldUtil
	{
		/**
		 * performs a bitwise disjunction (logical OR) on two bitfields and
		 * returns a new BitField as a result
		 */
		public function or(a:BitField, b:BitField):BitField
		{
			var result:BitField = a.clone();
			var length:uint = b.length;

			for (var i:int = 0; i < length; i++)
			{
				if (b.getBit(i))
					result.setBit(i, true);
			}

			return result;
		}

		/**
		 * performs a bitwise disjunction (logical OR) on two bitfields, changing
		 * the first bitfield as a result
		 */
		public function merge_or(mutable:BitField, argument:BitField):void
		{
			var length:uint = argument.length;
			for (var i:int = 0; i < length; i++)
			{
				if (argument.getBit(i))
					mutable.setBit(i, true);
			}
		}

		/**
		 * performs a bitwise conjunction (logical AND) on two bitfields and
		 * returns a new BitField as a result
		 */
		public function and(a:BitField, b:BitField):BitField
		{
			var result:BitField = a.clone();
			var length:uint = b.length;

			for (var i:int = 0; i < length; i++)
			{
				if (result.getBit(i) && !b.getBit(i))
					result.setBit(i, false);
			}

			return result;
		}

		/**
		 * performs a bitwise conjunction (logical AND) on two bitfields, changing
		 * the first bitfield as a result
		 */
		public function merge_and(mutable:BitField, argument:BitField):void
		{
			var length:uint = argument.length;
			for (var i:int = 0; i < length; i++)
			{
				if (mutable.getBit(i) && !argument.getBit(i))
					mutable.setBit(i, false);
			}
		}

		/**
		 * 	a	b	carry	result	carry
		 * 	0	0	0		0		(0)
		 * 	0	0	1		1 		(0)
		 * 	0	1	0		1 		(0)		2nd condition
		 * 	0	1	1		0 		(1)		2nd condition
		 * 	1	0	0		1 		(0)		2nd condition
		 * 	1	0	1		0 		(1)		2nd condition
		 * 	1	1	0		0 		(1)		first condition
		 * 	1	1	1		1 		(1)		first condition
		 */
		public function add(a:BitField, b:BitField):BitField
		{
			var aLength:uint = a.length;
			var bLength:uint = b.length;
			var length:uint = aLength > bLength ? aLength : bLength;
			var result:BitField = new BitField();
			var carry:Boolean = false;

			for (var i:int = 0; i < length; i++)
			{
				var aBit:Boolean = a.getBit(i);
				var bBit:Boolean = b.getBit(i);

				if (aBit && bBit)		// when both are true
				{
					result.setBit(i, carry);
					carry = true;
				}
				else if (aBit || bBit)	// when one is true
				{
					result.setBit(i, !carry);
				}
				else
				{
					result.setBit(i, carry);
					carry = false;
				}
			}

			if (carry)
				result.setBit(length, true);

			return result;
		}

	}
}
