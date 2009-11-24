package ui.paint 
{
	import flash.display.Graphics;

	import ui.Paint;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class SolidPaint implements Paint
	{
		
		private var _fill:uint;
		
		private var _stroke:uint;
		
		private var _width:int;
		
		public function SolidPaint(fill:uint, stroke:uint, width:int = -1)
		{
			_fill = fill;
			_stroke = stroke;
			_width = width;
		}
		
		public function get fill():uint
		{
			return _fill;
		}
		
		public function get stroke():uint
		{
			return _stroke;
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function beginPaint(graphics:Graphics):void
		{
			graphics.beginFill(_fill & 0xFFFFFF, _fill >>> 24);
			
			if (_width >= 0)
				graphics.lineStyle(_stroke & 0xFFFFFF, _stroke >>> 24);
			else
				graphics.lineStyle();
		}
		
		public function endPaint(graphics:Graphics):void
		{
			graphics.endFill();
		}
	}
}
