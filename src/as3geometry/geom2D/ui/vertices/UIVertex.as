package as3geometry.geom2D.ui.vertices
{
	import alecmce.invalidation.Invalidates;

	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.InteractiveVertex;
	import as3geometry.geom2D.ui.generic.UIMutableSprite;

	import alecmce.ui.Paint;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIVertex extends UIMutableSprite implements InteractiveVertex, Invalidates
	{
		private var _workingX:Number;

		private var _workingY:Number;

		private var _radius:uint;

		public function UIVertex(context:AS3GeometryContext, paint:Paint = null, radius:uint = 4)
		{
			super(context, paint);
			_radius = radius;
			invalidate();
		}

		override public function set x(value:Number):void
		{
			if (_workingX == value)				return;

			_workingX = value;
			invalidate();
		}

		override public function set y(value:Number):void
		{
			if (_workingY == value)
				return;

			_workingY = value;
			invalidate();
		}

		public function set(x:Number, y:Number):void
		{
			_workingX = x;
			_workingY = y;
			invalidate();
		}

		public function get radius():uint
		{
			return _radius;
		}

		public function set radius(radius:uint):void
		{
			_radius = radius;
			_redraw = true;
			invalidate();
		}

		override public function resolve():void
		{
			super.resolve();

			super.x = _workingX;
			super.y = _workingY;
		}


		override protected function redraw():void
		{
			var p:Paint = paint;
			graphics.clear();
			p.beginPaint(graphics);
			graphics.drawCircle(0, 0, _radius);
			p.endPaint(graphics);
		}

	}
}
