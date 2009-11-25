package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.mutable.Mutable;

	import ui.Paint;

	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class GeneralDrawer extends Shape 
	{
		private var _paint:Paint;
		
		public function GeneralDrawer(paint:Paint = null)
		{
			_paint = paint;
			redraw();
		}
		
		final public function get paint():Paint
		{
			return _paint;
		}
		
		final public function set paint(paint:Paint):void
		{
			_paint = paint;
			addEventListener(Event.ENTER_FRAME, redraw);
		}
		
		final override public function set x(value:Number):void
		{
			// do nothing
		}

		final override public function set y(value:Number):void
		{
			// do nothing
		}

		protected function onDefinienChanged(mutable:Mutable):void
		{
			addEventListener(Event.ENTER_FRAME, redraw);
		}

		final protected function redraw(event:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME, redraw);
			
			var p:Paint = _paint ? _paint : DEFAULT_PAINT;
			graphics.clear();
			p.beginPaint(graphics);
			draw();
			p.endPaint(graphics);
		}

		protected function draw():void
		{
			
		}
		
		
	}
}
