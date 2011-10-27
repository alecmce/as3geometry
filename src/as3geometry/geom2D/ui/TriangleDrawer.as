package as3geometry.geom2D.ui
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.ui.generic.UIDrawer;

	import alecmce.ui.Paint;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class TriangleDrawer extends UIDrawer
	{

		private var _triangle:Triangle;

		public function TriangleDrawer(context:AS3GeometryContext, triangle:Triangle, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_triangle = triangle);
			invalidate();
		}

		public function get triangle():Triangle
		{
			return _triangle;
		}

		public function set triangle(value:Triangle):void
		{
			if (_triangle == value)
				return;

			removeDefinien(_triangle);
			_triangle = value;
			addDefinien(_triangle);
			invalidate();
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
