package as3geometry.geom2D.vectors
{
	import as3geometry.geom2D.SpatialVector;

	/**
	 * Defines a vector that describes a translation on a cartesian plane
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableSpatialVector implements SpatialVector
	{

		private var i_:Number;

		private var j_:Number;

		private var length_:Number;


		public function ImmutableSpatialVector(i:Number, j:Number)
		{
			i_ = i;
			j_ = j;
			length_ = i_ * i_ + j_ * j_;
		}

		public function get i():Number
		{
			return i_;
		}

		public function get j():Number
		{
			return j_;
		}

		public function get length():Number
		{
			return length_;
		}

	}
}
