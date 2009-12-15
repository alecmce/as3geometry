package as3geometry.geom2D.ui.vertices 
{
	import as3geometry.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;
	import as3geometry.geom2D.util.AngleHelper;

	import ui.Paint;

	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIVertexOnCircle extends UIVertex implements VertexOnCircle, Mutable
	{
		private var _circle:Circle;
		
		private var _helper:AngleHelper;

		private var _tempX:Number;
		
		private var _tempY:Number;
		
		private var _angle:Number;
		
		public function UIVertexOnCircle(circle:Circle, angle:Number, paint:Paint = null, radius:uint = 4)
		{
			_circle = circle;
			if (_circle is Mutable)
				Mutable(_circle).changed.add(onCircleChanged);
			
			_angle = angle;
			_helper = new AngleHelper();
			
			super(paint, radius);
			super.x = Math.cos(_angle) * _circle.radius;
			super.y = Math.sin(_angle) * _circle.radius;
		}

		override public function set x(value:Number):void
		{
			_tempX = value;
			addEventListener(Event.ENTER_FRAME, calculate, false, 100);
		}

		override public function set y(value:Number):void
		{
			_tempY = value;
			addEventListener(Event.ENTER_FRAME, calculate, false, 100);
		}

		private function calculate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, calculate);
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			_angle = Math.atan2(_tempY - center.y, _tempX - center.x);
			
			super.x = Math.cos(_angle) * radius;			super.y = Math.sin(_angle) * radius;
		}
		
		private function onCircleChanged(mutable:Mutable):void
		{
			mutable; // escape FDT warning
			
			var center:Vertex = _circle.center;
			var radius:Number = _circle.radius;
			
			_angle = Math.atan2(y - center.y, x - center.x);
			
			super.x = Math.cos(_angle) * radius;
			super.y = Math.sin(_angle) * radius;
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
	}
}
