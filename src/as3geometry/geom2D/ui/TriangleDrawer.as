package as3geometry.geom2D.ui 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.geom2D.Triangle;

	import ui.Paint;

	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class TriangleDrawer extends GeneralDrawer
	{
	
		private var _triangle:Triangle;
	
		public function TriangleDrawer(triangle:Triangle, paint:Paint = null)
		{
			_triangle = triangle;
			if (_triangle is Mutable)
				Mutable(_triangle).changed.add(onDefinienChanged);
			
			super(paint);		
		}
		
		public function get triangle():Triangle
		{
			return _triangle;
		}
		
		public function set triangle(value:Triangle):void
		{
			if (_triangle == value)
				return;
			
			if (_triangle is Mutable)
				Mutable(_triangle).changed.remove(onDefinienChanged);
			
			_triangle = value;
			
			if (_triangle is Mutable)
				Mutable(_triangle).changed.add(onDefinienChanged);
		
			addEventListener(Event.ENTER_FRAME, redraw);
		}

		override protected function draw():void
		{
			graphics.moveTo(triangle.a.x, triangle.a.y);
			graphics.lineTo(triangle.b.x, triangle.b.y);
			graphics.lineTo(triangle.c.x, triangle.c.y);
			graphics.lineTo(triangle.a.x, triangle.a.y);
		}
	}
}
