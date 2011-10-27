package as3geometry.geom2D.util
{
	import as3geometry.geom2D.InteractiveVertex;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.vertices.ImmutableVertex;

	public class ParabolaHelper
	{

		public function vertexFromParameter(parabola:Parabola, t:Number, target:InteractiveVertex = null):Vertex
		{
			var line:Line = parabola.directrix;

			var a:Vertex = line.a;
			var ax:Number = a.x;
			var ay:Number = a.y;

			var b:Vertex = line.b;
			var bx:Number = b.x;
			var by:Number = b.y;

			var c:Vertex = parabola.focus;
			var cx:Number = c.x;
			var cy:Number = c.y;

			var ab_x:Number = bx - ax;
			var ab_y:Number = by - ay;

			// d is the point on the line ab defined by t
			var dx:Number = ax + ab_x * t;
			var dy:Number = ay + ab_y * t;

			var dc_x:Number = dx - cx;
			var dc_y:Number = dy - cy;

			var n:Number = (dc_x * dc_x + dc_y * dc_y) / (2 * (ab_x * dc_y - ab_y * dc_x));
			var ex:Number = dx + ab_y * n;
			var ey:Number = dy - ab_x * n;

			if (target)
			{
				target.set(ex, ey);
				return target;
			}

			return new ImmutableVertex(ex, ey);
		}

	}
}
