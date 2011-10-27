package alecmce.ui.paint
{
	import alecmce.ui.Paint;

	import flash.display.Graphics;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class SolidPaint implements Paint
	{

		private static const ALPHA_SCALAR:Number = 1 / 0xFF;

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
			if (_fill)
				graphics.beginFill(_fill & 0xFFFFFF, (_fill >>> 24) * ALPHA_SCALAR);

			if (_width >= 0)
				graphics.lineStyle(_width, _stroke & 0xFFFFFF, (_stroke >>> 24) * ALPHA_SCALAR);
			else
				graphics.lineStyle();
		}

		public function endPaint(graphics:Graphics):void
		{
			if (_fill)
				graphics.endFill();
		}
	}
}
