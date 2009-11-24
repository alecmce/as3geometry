package as3geometry.geom2D.drawable 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	import flash.display.Graphics;
	import flash.geom.Rectangle;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class LineDrawer 
	{
		
		private var _bounds:Rectangle;
		
		private var diagonal:Number;
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function set bounds(bounds:Rectangle):void
		{
			_bounds = bounds;
			
			var w:Number = _bounds.width;
			var h:Number = _bounds.height;
			diagonal = Math.sqrt(w * w + h * h);
		}
		
		public function draw(graphics:Graphics, line:Line, paint:Paint):void
		{
			paint.beginPaint(graphics);
			
			switch (line.type)
			{
				case LineType.LINE:
					drawLine(graphics, line.a, line.b);
					break;
				case LineType.RAY:
					drawRay(graphics, line.a, line.b);
					break;
				case LineType.SEGMENT:
					drawSegment(graphics, line.a, line.b);
					break;
			}
			
			paint.endPaint(graphics);
		}
		
		
		private function drawSegment(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			graphics.moveTo(a.x, a.y);			graphics.lineTo(b.x, b.y);
		}
		
		private function drawRay(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			graphics.moveTo(a.x, a.y);
			
			var i:Number = b.x - a.x;
			var j:Number = b.y - a.y;
			
			var length:Number = Math.sqrt(i * i + j * j);
			var multiplier:Number = diagonal / length;
			
			i *= multiplier;			j *= multiplier;
			
			graphics.lineTo(b.x + i, b.y + j);
		}
		
		private function drawLine(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			var i:Number = b.x - a.x;
			var j:Number = b.y - a.y;
			
			var length:Number = Math.sqrt(i * i + j * j);
			var multiplier:Number = diagonal / length;
			
			i *= multiplier;
			j *= multiplier;
			
			graphics.moveTo(a.x - i, a.y - j);
			graphics.lineTo(b.x + i, b.y + j);
		}
	}
}
