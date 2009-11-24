package as3geometry.geom2D.drawable 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	import flash.display.Graphics;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonDrawer 
	{
		
		public function draw(graphics:Graphics, polygon:Polygon, paint:Paint):void
		{
			paint.beginPaint(graphics);
			
			var vertex:Vertex = polygon.get(0);
			graphics.moveTo(vertex.x, vertex.y);
			
			var i:int = polygon.count;
			while (--i > -1)
			{
				vertex = polygon.get(i);
				graphics.lineTo(vertex.x, vertex.y);	
			}
			
			
			paint.endPaint(graphics);
		}
		
	}
}
