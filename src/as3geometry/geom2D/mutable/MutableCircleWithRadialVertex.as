package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircleWithRadialVertex extends AbstractMutable implements Circle, Mutable
	{
		private var _center:Vertex;
		private var _radial:Vertex;
		private var _radius:Number;
		
		private var _invalidated:Boolean;

		public function MutableCircleWithRadialVertex(center:Vertex, radial:Vertex)
		{
			addDefinien(_center = center);
			addDefinien(_radial = radial);

			_radius = calculateRadius();
			_invalidated = false;
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
			
			_changed.dispatch(this);
		}
		
		public function get radius():Number
		{
			if (_invalidated)
			{
				_invalidated = false;
				_radius = calculateRadius();
			}
			
			return _radius;
		}
		
		override protected function onDefinienChanged(mutable:Mutable):void
		{
			_invalidated = true;
			super.onDefinienChanged(mutable);
		}
		
		private function calculateRadius():Number
		{
			var x:Number = _radial.x - _center.x;
			var y:Number = _radial.y - _center.y;
			
			return Math.sqrt(x * x + y * y);
		}
		
		public function toString():String
		{
			return "[CIRCLE " + _center + " -> " + _radial + ", r=" + radius + "]";
		}
		
	}
}
