package alecmce.data.bitwise
{

	public class BitField
	{
		private var _vector:Vector.<uint>;

		public function BitField()
		{
			_vector = new Vector.<uint>();
			_vector[0] = 0;
		}

		public function get length():uint
		{
			return _vector.length << 5;
		}

		public function getBit(position:uint):Boolean
		{
			var index:uint = position >> 5;
			var bit:uint = 1 << (position % 32);

			if (_vector.length <= index)
				return false;

			return Boolean(_vector[index] & bit);
		}

		public function setBit(position:uint, value:Boolean):void
		{
			if (position == -1)
				throw new Error("invalid bit position -1");

			var index:uint = position >> 5;
			var bit:uint = 1 << (position % 32);

			while (_vector.length <= index)
				_vector.push(0);

			var current:uint = _vector[index];
			_vector[index] = value ? current | bit : ~(~current | bit);
		}

		public function serialize(base:BitFieldBase):String
		{
			var strings:Vector.<String> = new Vector.<String>();

			switch (base)
			{
				case BitFieldBase.BASE_2:
				case BitFieldBase.BASE_16:
					var length:uint = _vector.length;
					for (var i:int = 0;i < length;i++)
						strings.unshift(base.encode(_vector[i]));

					break;

				default:
					throw new Error("base not supported in seralize method");
					break;
			}

			return strings.join("");
		}

		public function deserialize(value:String, base:BitFieldBase):void
		{
			_vector = new Vector.<uint>();

			switch (base)
			{
				case BitFieldBase.BASE_2:
				case BitFieldBase.BASE_16:
					var firstChar:uint = 0;
					var charsPer32Bit:uint = base.charsPer32Bit;
					var length:uint = Math.ceil(value.length / charsPer32Bit);

					for (var i:int = 0;i < length;i++)
					{
						var string:String = value.substr(firstChar, charsPer32Bit);
						firstChar += charsPer32Bit;
						_vector.push(base.decode(string));
					}

					break;

				default:
					throw new Error("base not supported in deseralize method");
					break;
			}
		}

		public function clone():BitField
		{
			var field:BitField = new BitField();
			field._vector = _vector.concat();

			return field;
		}
	}
}
