package as3geometry.geom2D.ui.vertices 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;
	import as3geometry.geom2D.ui.DEFAULT_PAINT;
	import as3geometry.geom2D.util.AngleHelper;

	import ui.Paint;

	import org.osflash.signals.Signal;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIVertexOnCircle extends Sprite implements VertexOnCircle, Mutable
	{
		private var _circle:Circle;
		
		private var _helper:AngleHelper;

		private var _tempX:Number;
		
		private var _tempY:Number;
		
		private var _radius:uint;
		
		private var _paint:Paint;
		
		private var _angle:Number;
		
		private var _changed:Signal;
		
		public function UIVertexOnCircle(circle:Circle, angle:Number, paint:Paint = null, radius:uint = 4)
		{
			_changed = new Signal(Mutable);
			
			_circle = circle;
			if (_circle is Mutable)
				Mutable(_circle).changed.add(onCircleChanged);
			
			_angle = angle;
			_helper = new AngleHelper();
			
			_paint = paint ? paint : DEFAULT_PAINT;
			_radius = radius;
			redraw();
			
			super.x = Math.cos(_angle) * _circle.radius;
			super.y = Math.sin(_angle) * _circle.radius;
		}

		override public function set x(value:Number):void
		{
			if (_tempX == value)
				return;
			
			_tempX = value;
			addEventListener(Event.ENTER_FRAME, calculate, false, 100);
			_changed.dispatch(this);
		}

		override public function set y(value:Number):void
		{
			if (_tempY == value)
				return;
			
			_tempY = value;
			addEventListener(Event.ENTER_FRAME, calculate, false, 100);			_changed.dispatch(this);
		}

		private function calculate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, calculate);
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			var cx:Number = center.x;
			var cy:Number = center.y;
			
			_angle = Math.atan2(_tempY - cy, _tempX - cx);
						super.x = cx + Math.cos(_angle) * radius;
			super.y = cy + Math.sin(_angle) * radius;
			
		}
		
		private function onCircleChanged(mutable:Mutable):void
		{
			mutable; // escape FDT warning
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			_angle = Math.atan2(y - center.y, x - center.x);
			
			super.x = center.x + Math.cos(_angle) * radius;
			super.y = center.y + Math.sin(_angle) * radius;
			
			_changed.dispatch(this);
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		private function redraw(event:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME, redraw);
			
			graphics.clear();
			
			_paint.beginPaint(graphics);
			graphics.drawCircle(0, 0, _radius);
			_paint.endPaint(graphics);
		}
		
		public function get changed():Signal
		{
			return _changed;
		}
		
		public function set angle(angle:Number):void
		{
			_angle = angle;
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			super.x = center.x + Math.cos(_angle) * radius;
			super.y = center.y + Math.sin(_angle) * radius;

			_changed.dispatch(this);
		}
	}
}
