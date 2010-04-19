package as3geometry.geom2D.circle 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.abstract.AbstractMutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircle extends AbstractMutable implements Circle, Mutable
	{
		
		private var _center:Vertex;
		private var _radius:Number;
		
		public function MutableCircle(center:Vertex, radius:Number)
		{
			super();
			
			addDefinien(_center = center);
			_radius = radius;
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
			
			_changed.dispatch(this);
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
			_changed.dispatch(this);
		}
		
		public function toString():String
		{
			return "[CIRCLE " + center + ", r=" + radius + "]";
		}
		
	}
}
