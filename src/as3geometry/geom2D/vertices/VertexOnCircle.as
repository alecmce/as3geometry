package as3geometry.geom2D.vertices 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
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
	public class VertexOnCircle extends Mutable implements VertexOnCircle
	{
		private var _circle:Circle;
		private var _angle:Number;
		
		private var _x:Number;		private var _y:Number;
		private var _recalculateAngle:Boolean;

		public function VertexOnCircle(context:AS3GeometryContext, circle:Circle, angle:Number)
		{
			super(context);
			addDefinien(_circle = circle);
			_angle = angle;
			invalidate();
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(value:Number):void
		{
			_angle = value;
			invalidate();
		}

		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}

		override public function resolve():void 
		{
			super.resolve();
			
			var center:Vertex = _circle.center;
			
			if (_recalculateAngle)
			{
				_angle = Math.atan2(_y - center.y, _x - center.x);
				_recalculateAngle = false;
			}
			
			var radius:Number = _circle.radius;
			_x = center.x + radius * Math.cos(_angle);			_y = center.y + radius * Math.sin(_angle);
		}
		
		public function set(x:Number, y:Number):void
		{
			_x = x;
			_y = y;
			_recalculateAngle = true;
			invalidate();
		}
		
		public function set x(value:Number):void
		{
			_x = value;
			_recalculateAngle = true;
			invalidate();
		}
		
		public function set y(value:Number):void
		{
			_y = value;
			_recalculateAngle = true;
			invalidate();
		}
	}
}
