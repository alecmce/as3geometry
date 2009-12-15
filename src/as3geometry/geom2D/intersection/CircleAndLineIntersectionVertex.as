package as3geometry.geom2D.intersection 
{
	import as3geometry.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;

	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class CircleAndLineIntersectionVertex implements VertexOnCircle, Mutable
	{
		private var _changed:Signal;

		private var _circle:Circle;
		private var _x:Number;
		private var _y:Number;
		private var _angle:Number;

		public function CircleAndLineIntersectionVertex()
		{
			_changed = new Signal(Mutable);
			_circle = null;
			_angle = Number.NaN;
			_x = Number.NaN;
			_y = Number.NaN;
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		internal function update(circle:Circle, x:Number, y:Number):void
		{
			_circle = circle;
			_x = x;
			_y = y;
			
			if (isNaN(_x) || isNaN(_y))
			{
				_angle = Number.NaN;
			}
			else
			{
				var center:Vertex = _circle.center;
				_angle = Math.atan2(_y - center.y, _x - center.x);
			}
			
			_changed.dispatch(this);
		}
		
		public function get changed():Signal
		{
			return _changed;
		}
	}
}
