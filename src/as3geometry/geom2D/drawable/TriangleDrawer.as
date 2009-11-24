package as3geometry.geom2D.drawable 
{
	import as3geometry.geom2D.Triangle;

	import ui.Paint;

	import flash.display.Graphics;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class TriangleDrawer 
	{
		
		public function draw(graphics:Graphics, triangle:Triangle, paint:Paint):void
		{
			paint.beginPaint(graphics);
			graphics.moveTo(triangle.a.x, triangle.a.y);
			paint.endPaint(graphics);
		}
		
	}
}