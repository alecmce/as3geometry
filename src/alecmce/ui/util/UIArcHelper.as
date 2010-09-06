package alecmce.ui.util 
{
	import as3geometry.geom2D.vertices.ImmutableVertex;

	import flash.display.Graphics;

	/**
	 * A graphical method for approximating an arc by drawing a sequence of bezier curves.
	 * 
	 * This algorithm takes the simple approach of calculating quadratic bezier curves the midpoint for which
	 * lies on the circle that it approximates. All of the quadratic curves therefore lie slightly inside the circle. It
	 * might be possible to add a small adjustment variable to this approximation to improve the perception of an arc for
	 * extremely large values, but this would need a great deal of care and testing as it would almost certainly be an ad-hoc
	 * solution.
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIArcHelper 
	{
		
		public function arcInitialPosition(x:Number, y:Number, radius:Number, start:Number):ImmutableVertex
		{
			var nx:Number = x + radius * Math.cos(start);
			var ny:Number = y + radius * Math.sin(start);
			return new ImmutableVertex(nx, ny);
		}
		
		public function drawArc(graphics:Graphics, x:Number, y:Number, radius:Number, start:Number, sweep:Number, curves:uint = 8):void
		{
			var dAngle:Number = sweep / (2 * curves);
			var angle:Number = start;
			
			var multiplied:Number = radius * (2 - Math.cos(dAngle));
			
			for (var i:uint = 0; i < curves; i++)
			{
				angle += dAngle;
				var cx:Number = x + multiplied * Math.cos(angle);				var cy:Number = y + multiplied * Math.sin(angle);
				
				angle += dAngle;
				var nx:Number = x + radius * Math.cos(angle);
				var ny:Number = y + radius * Math.sin(angle);
				
				graphics.curveTo(cx, cy, nx, ny);
			}
		}
		
	}
}
