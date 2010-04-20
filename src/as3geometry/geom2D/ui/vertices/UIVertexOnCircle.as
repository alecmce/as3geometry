package as3geometry.geom2D.ui.vertices 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;
	import as3geometry.geom2D.ui.generic.UIMutableSprite;
	import as3geometry.geom2D.util.AngleHelper;

	import ui.Paint;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIVertexOnCircle extends UIMutableSprite implements VertexOnCircle
	{
		private var _circle:Circle;
		
		private var _helper:AngleHelper;

		private var _tempX:Number;
		
		private var _tempY:Number;
		
		private var _radius:uint;
		
		private var _angle:Number;
		
		public function UIVertexOnCircle(context:AS3GeometryContext, circle:Circle, angle:Number, paint:Paint = null, radius:uint = 4)
		{
			super(context, paint);
			addDefinien(_circle = circle);
			_angle = angle;
			_helper = new AngleHelper();
			_radius = radius;
			invalidate();
		}

		override public function set x(value:Number):void
		{
			if (_tempX == value)
				return;
			
			_tempX = value;
			invalidate();
		}

		override public function set y(value:Number):void
		{
			if (_tempY == value)
				return;
			
			_tempY = value;
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
		
		public function set angle(angle:Number):void
		{
			_angle = angle;
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			super.x = center.x + Math.cos(_angle) * radius;
			super.y = center.y + Math.sin(_angle) * radius;

			invalidate();
		}

		override public function resolve():void 
		{
			super.resolve();

			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			var cx:Number = center.x;
			var cy:Number = center.y;
			
			_angle = Math.atan2(_tempY - cy, _tempX - cx);
			
			super.x = cx + Math.cos(_angle) * radius;
			super.y = cy + Math.sin(_angle) * radius;

			var p:Paint = paint;
			graphics.clear();
			p.beginPaint(graphics);
			graphics.drawCircle(0, 0, _radius);
			p.endPaint(graphics);
		}
		
	}
}
