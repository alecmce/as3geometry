package as3geometry.geom2D.circle
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircle extends Mutable implements Circle
	{

		private var _center:Vertex;
		private var _radius:Number;

		public function MutableCircle(context:AS3GeometryContext, center:Vertex, radius:Number)
		{
			super(context);
			addDefinien(_center = center);
			_radius = radius;
			invalidate(true);
		}

		public function get center():Vertex
		{
			return _center;
		}

		public function set center(value:Vertex):void
		{
			if (_center == value)
				return;

			removeDefinien(_center);
			_center = value;
			addDefinien(_center);
			invalidate();
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			if (_radius == value)
				return;

			_radius = value;
			invalidate();
		}

		public function toString():String
		{
			return "[CIRCLE " + center + ", r=" + radius + "]";
		}

	}
}
