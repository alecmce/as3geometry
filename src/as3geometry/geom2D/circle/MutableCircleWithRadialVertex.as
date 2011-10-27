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
	public class MutableCircleWithRadialVertex extends Mutable implements Circle
	{
		private var _center:Vertex;
		private var _radial:Vertex;
		private var _radius:Number;

		public function MutableCircleWithRadialVertex(context:AS3GeometryContext, center:Vertex, radial:Vertex)
		{
			super(context);
			addDefinien(_center = center);
			addDefinien(_radial = radial);
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
			invalidate(true);
		}

		public function get radial():Vertex
		{
			return _radial;
		}

		public function set radial(value:Vertex):void
		{
			if (_radial == value)
				return;

			removeDefinien(_radial);
			_radial = value;
			addDefinien(_radial);
			invalidate();
		}

		public function get radius():Number
		{
			return _radius;
		}

		override public function resolve():void
		{
			super.resolve();

			var x:Number = _radial.x - _center.x;
			var y:Number = _radial.y - _center.y;
			trace("[RESOLVE] MutableCircleWithRadialVertex", x, y);

			_radius = Math.sqrt(x * x + y * y);
		}

		public function toString():String
		{
			return "[CIRCLE " + _center + " -> " + _radial + ", r=" + radius + "]";
		}

	}
}
