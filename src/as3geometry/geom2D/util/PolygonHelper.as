package as3geometry.geom2D.util 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	/**
	 * A collection of methods that are used to determine the properties of Polygons
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonHelper 
	{
		private const APPROXIMATE_ZERO:Number = 0.0001;
		
		public function polygonContains(polygon:Polygon, vertex:Vertex):Boolean
		{
			var angleSum:Number = 0;
			var len:uint = polygon.countVertices;
			
			var lineHelper:LineHelper = new LineHelper();
			var angleHelper:AngleHelper = new AngleHelper();
			
			for (var i:uint = 0; i < len; i++)
			{
				var line:Line = polygon.getEdge(i);
				if (lineHelper.isColinear(line, vertex))
					return true;
				
				angleSum += angleHelper.directedAngleFromVertices(vertex, line.a, line.b);
			}
			
			if (angleSum < 0)
				return angleSum < -APPROXIMATE_ZERO;
			else
				return angleSum > APPROXIMATE_ZERO;
		}
		
		public function vertexPolygonContains(vertices:Array, vertex:Vertex):Boolean
		{
			var angleSum:Number = 0;
			var len:uint = vertices.length;
			
			var lineHelper:LineHelper = new LineHelper();
			var angleHelper:AngleHelper = new AngleHelper();
			
			var a:Vertex = vertices[len - 1];
			for (var i:uint = 0; i < len; i++)
			{
				var b:Vertex = vertices[i];
				
				if (lineHelper.isColinearByVertices(a, b, vertex))
					return true;
				
				angleSum += angleHelper.directedAngleFromVertices(vertex, a, b);
				a = b;
			}
			
			if (angleSum < 0)
				return angleSum < -APPROXIMATE_ZERO;
			else
				return angleSum > APPROXIMATE_ZERO;
		}
		
		public function isPolygonClockwise(polygon:Polygon):Boolean
		{
			var value:Number = 0;
			var count:uint = polygon.countVertices;
			
			var a:Vertex = polygon.getVertex(0);
			for (var i:uint = 1; i < count; i++)
			{
				var b:Vertex = polygon.getVertex(i);
				value += a.x * b.y - b.x * a.y;
				a = b;
			}
			
			return value < 0;
		}
		
		/**
		 * This method will fail if the vertices are not Vector, but the different
		 * types of input Vector preclude generic-typing.
		 */
		public function isVertexPolygonClockwise(vertices:Array, count:int = -1):Boolean
		{
			var value:Number = 0;
			
			if (count == -1)
				count = vertices.length;
			
			var a:Vertex = vertices[0];
			for (var i:uint = 1; i < count; i++)
			{
				var b:Vertex = vertices[i];
				value += a.x * b.y - b.x * a.y;
				a = b;
			}
			
			return value < 0;
		}
		
		
	}
}
