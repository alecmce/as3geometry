package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircleWithRadialVertex implements Circle, Mutable
	{
		private var _center:Vertex;
				
		private var _radial:Vertex;
				
		private var _radius:Number;
		
		private var _invalidated:Boolean;
		
		private var _changed:ISignal;

		public function MutableCircleWithRadialVertex(center:Vertex, radial:Vertex)
		{
			_center = center;
			if (_center is Mutable)
				Mutable(_center).changed.add(onDefinienChanged);
			
			_radial = radial;
			if (_radial is Mutable)
				Mutable(_radial).changed.add(onDefinienChanged);
			
			_changed = new Signal(this, Mutable);
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
			
			if (_center is Mutable)
				Mutable(_center).changed.remove(onDefinienChanged);
			
			_center = value;
		
			if (_center is Mutable)
				Mutable(_center).changed.add(onDefinienChanged);
		}
		
		public function get radial():Vertex
		{
			return _radial;
		}
		
		public function set radial(value:Vertex):void
		{
			if (_radial == value)
				return;
			
			if (_radial is Mutable)
				Mutable(_radial).changed.remove(onDefinienChanged);
			
			_radial = value;
			
			if (_radial is Mutable)
				Mutable(_radial).changed.add(onDefinienChanged);
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
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_invalidated = true;
			_changed.dispatch(mutable);
		}
		
		private function calculateRadius():Number
		{
			var x:Number = _radial.x - _center.x;
			var y:Number = _radial.y - _center.y;
			
			return Math.sqrt(x * x + y * y);
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
		
		public function toString():String
		{
			return "[CIRCLE " + _center + " -> " + _radial + ", r=" + radius + "]";
		}
		
	}
}
