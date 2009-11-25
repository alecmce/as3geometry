package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutableVertex;
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
	public class MutableCircle implements Circle, Mutable
	{
		
		private var _center:Vertex;
				
		private var _radius:Number;
		
		private var _changed:ISignal;

		public function MutableCircle(center:Vertex = null, radius:Number = 1)
		{
			_center = center ? center : new ImmutableVertex(0, 0);
			if (_center is Mutable)
				Mutable(_center).changed.add(onDefinienChanged);
			
			_changed = new Signal(this, Mutable);
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
			
			if (_center is Mutable)
				Mutable(_center).changed.remove(onDefinienChanged);
			
			_center = value;
		
			if (_center is Mutable)
				Mutable(_center).changed.add(onDefinienChanged);
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function toString():String
		{
			return "[CIRCLE " + center + ", r=" + radius + "]";
		}
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
