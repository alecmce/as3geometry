package as3geometry.geom2D.intersection 
{
	import alecmce.invalidation.signals.InvalidationSignal;

	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class CircleAndLineIntersectionVertex implements VertexOnCircle
	{
		private var _invalidated:InvalidationSignal;

		private var _circle:Circle;
		private var _x:Number;
		private var _y:Number;
		private var _angle:Number;

		public function CircleAndLineIntersectionVertex()
		{
			_invalidated = new InvalidationSignal();
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
			
			_invalidated.dispatch(this);
		}
		
		public function get changed():InvalidationSignal
		{
			return _invalidated;
		}
	}
}
