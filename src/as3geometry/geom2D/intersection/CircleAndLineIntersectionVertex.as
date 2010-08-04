package as3geometry.geom2D.intersection 
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.signals.InvalidationSignal;

	import as3geometry.AS3GeometryContext;
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
	internal class CircleAndLineIntersectionVertex implements VertexOnCircle, Invalidates
	{
		private var _invalidated:InvalidationSignal;
		private var _isInvalidated:Boolean;
		
		private var _circle:Circle;
		private var _x:Number;
		private var _y:Number;
		private var _angle:Number;

		public function CircleAndLineIntersectionVertex(context:AS3GeometryContext, container:IntersectionOfCircleAndLine)
		{
			_invalidated = new InvalidationSignal();
			_isInvalidated = false;
			
			context.invalidationManager.addDependency(container, this);
			
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
		
		public function invalidate(resolveImmediately:Boolean = false):void
		{
			_isInvalidated = true;
			_invalidated.dispatch(this, resolveImmediately);
		}
		
		public function resolve():void
		{
			// do nothing - in this unusual case resolve is deferred to the
			// IntersectionOfCircleAndLine container object that performs the
			// calculation and calls update in it's own resolve cycle. Because
			// the container object is a definien, it must be resolved before
			// this object
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
			
			_isInvalidated = false;
		}
		
		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get isInvalid():Boolean
		{
			return _isInvalidated;
		}
	}
}
