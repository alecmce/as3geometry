package as3geometry.geom2D.ui 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	import flash.events.Event;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleDrawer extends GeneralDrawer
	{
		
		private var _circle:Circle;
		
		public function CircleDrawer(circle:Circle, paint:Paint = null)
		{
			_circle = circle;
			if (_circle is Mutable)
				Mutable(_circle).changed.add(onDefinienChanged);
			
			super(paint);
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function set circle(value:Circle):void
		{
			if (_circle == value)
				return;
			
			if (_circle is Mutable)
				Mutable(_circle).changed.remove(onDefinienChanged);
			
			_circle = value;
			
			if (_circle is Mutable)
				Mutable(_circle).changed.add(onDefinienChanged);
				
			addEventListener(Event.ENTER_FRAME, redraw);		}

		override protected function draw():void
		{
			var c:Vertex = _circle.center;
			graphics.drawCircle(c.x, c.y, _circle.radius);
		}

	}
}
