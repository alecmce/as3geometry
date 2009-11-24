package as3geometry.geom2D.drawable 
{
	import as3geometry.geom2D.Circle;

	import ui.Paint;

	import flash.display.Graphics;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleDrawer 
	{
		
		public function draw(graphics:Graphics, circle:Circle, paint:Paint):void
		{
			paint.beginPaint(graphics);
			graphics.drawCircle(circle.center.x, circle.center.y, circle.radius);
			paint.endPaint(graphics);
		}
		
	}
}
