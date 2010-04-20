package as3geometry.geom2D.vertices 
{
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Vertex;

	import org.osflash.signals.Signal;

	import flash.events.EventDispatcher;

	/**
	 * Defines a vertex on a cartesian plane the position of whcih can be changed
	 * by setting its x and y values
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableVertex extends EventDispatcher implements Vertex 
	{
		
		private var _x:Number;
		private var _y:Number;
		
		private var _changed:Signal;
		
		public function MutableVertex(x:Number, y:Number)
		{
			_x = x;
			_y = y;
			_changed = new Signal(Mutable);
		}
		
		public function set x(value:Number):void
		{
			if (_x == value)
				return;
			
			_x = value;
			_changed.dispatch(this);
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
			_changed.dispatch(this);
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get changed():Signal
		{
			return _changed;
		}
		
		public function set(x:Number, y:Number):void
		{
			_x = x;
			_y = y;
			_changed.dispatch(this);
		}
	}
}
