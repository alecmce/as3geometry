package alecmce.data.bitwise
{

	public class BitFieldBase 
	{

		public static const BASE_16:BitFieldBase = new BitFieldBase(16);		public static const BASE_2:BitFieldBase = new BitFieldBase(2);

		private var _radix:uint;
		private var _charsPer32Bit:uint;

		public function BitFieldBase(radix:uint) 
		{
			_radix = radix;
			_charsPer32Bit = 32 / (1 << Math.log(radix));
		}

		public function encode(value:uint):String
		{
			var chars:Array = value.toString(_radix).split("");
			var len:uint = chars.length;
			while (len++ < _charsPer32Bit)
				chars.unshift(0);
			
			return chars.join("");
		}

		public function decode(value:String):uint
		{
			return parseInt(value, _radix);
		}

		public function get charsPer32Bit():uint
		{
			return _charsPer32Bit;
		}
	}
}
