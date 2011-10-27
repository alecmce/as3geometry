package as3geometry.geom2D.util
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;

	/**
	 * Contains functions to calculate properties of lines
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class LineHelper
	{

		public function isColinearByVertices(lineA:Vertex, lineB:Vertex, vertex:Vertex):Boolean
		{
			var j:Number = lineB.x - lineA.x;
			var i:Number = lineB.y - lineA.y;

			return j * (vertex.x - lineA.x) == i * (vertex.y - lineA.y);
		}

		public function isColinear(line:Line, vertex:Vertex):Boolean
		{
			var a:Vertex = line.a;
			var v:SpatialVector = line.vector;

			return v.j * (vertex.x - a.x) == v.i * (vertex.y - a.y);
		}

	}
}
