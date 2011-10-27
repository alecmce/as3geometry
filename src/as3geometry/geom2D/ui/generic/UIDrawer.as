package as3geometry.geom2D.ui.generic
{
	import as3geometry.AS3GeometryContext;

	import alecmce.ui.Paint;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIDrawer extends UIMutableSprite
	{
		public function UIDrawer(context:AS3GeometryContext, paint:Paint = null)
		{
			super(context, paint);
			invalidate();
		}

		final override public function set x(value:Number):void
		{
			// do nothing
		}

		final override public function set y(value:Number):void
		{
			// do nothing
		}

		override public function resolve():void
		{
			super.resolve();

			var p:Paint = paint;
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
