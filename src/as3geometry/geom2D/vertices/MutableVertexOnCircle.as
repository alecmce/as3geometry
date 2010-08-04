package as3geometry.geom2D.vertices 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.VertexOnCircle;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableVertexOnCircle extends Mutable implements VertexOnCircle
	{
		private var _circle:Circle;
		private var _angle:Number;
		
		private var _x:Number;		private var _y:Number;

		public function MutableVertexOnCircle(context:AS3GeometryContext, circle:Circle, angle:Number)
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
			if (_angle == value)
				return;
			
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
			
			var radius:Number = _circle.radius;
			_x = radius * Math.cos(_angle);			_y = radius * Math.sin(_angle);
		}
	}
}
