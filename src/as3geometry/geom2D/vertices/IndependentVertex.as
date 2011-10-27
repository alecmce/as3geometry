package as3geometry.geom2D.vertices
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.InteractiveVertex;

	/**
	 * Defines an independent vertex on a cartesian plane the position of which
	 * can be changed by setting its x and y values or by using the set method
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IndependentVertex extends Mutable implements InteractiveVertex
	{

		private var _x:Number;
		private var _y:Number;

		public function IndependentVertex(context:AS3GeometryContext, x:Number, y:Number)
		{
			super(context);

			_x = x;
			_y = y;
		}

		public function set x(value:Number):void
		{
			if (_x == value)
				return;

			_x = value;
			invalidate();
		}

		public function get x():Number
		{
			return _x;
		}

		public function set y(value:Number):void
		{
			if (_y == value)
				return;

			_y = value;
			invalidate();
		}

		public function get y():Number
		{
			return _y;
		}


		public function set(x:Number, y:Number):void
		{
			_x = x;
			_y = y;
			invalidate();
		}
	}
}
