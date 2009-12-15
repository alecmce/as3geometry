package as3geometry.geom2D.ui.vertices 
{
	import as3geometry.Mutable;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.DEFAULT_PAINT;

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
	public class UIVertex extends Sprite implements Vertex, Mutable
	{
		private var _radius:uint;
		
		private var _paint:Paint;

		private var _changed:Signal;
		
		public function UIVertex(paint:Paint = null, radius:uint = 4)
		{
			_changed = new Signal(Mutable);
			
			_paint = paint;
			_radius = radius;
			redraw();
		}

		override public function set x(value:Number):void
		{
			if (super.x == value)
				return;
			
			super.x = value;
			addEventListener(Event.ENTER_FRAME, update);		}

		override public function set y(value:Number):void
		{
			if (super.x == value)
				return;
			
			super.y = value;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			_changed.dispatch(this);
		}

		public function get changed():Signal
		{
			return _changed;
		}
		
		public function get radius():uint
		{
			return _radius;
		}
		
		public function set radius(radius:uint):void
		{
			_radius = radius;
			addEventListener(Event.ENTER_FRAME, redraw);		}
		
		public function get paint():Paint
		{
			return _paint;
		}
		
		public function set paint(value:Paint):void
		{
			_paint = value;
			addEventListener(Event.ENTER_FRAME, redraw);		}
		
		private function redraw(event:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME, redraw);
			
			graphics.clear();
			
			var p:Paint = _paint ? _paint : DEFAULT_PAINT;
			p.beginPaint(graphics);
			graphics.drawCircle(0, 0, _radius);
			p.endPaint(graphics);
		}
	}
}
