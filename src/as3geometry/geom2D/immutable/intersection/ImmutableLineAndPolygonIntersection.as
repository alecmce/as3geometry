package as3geometry.geom2D.immutable.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.immutable.ImmutableLine;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableLineAndPolygonIntersection 
	{

		private var _polygon:Polygon;
		
		private var _line:Line;
		
		private var _vertices:Vector.<Vertex>;
		
		public function ImmutableLineAndPolygonIntersection(polygon:Polygon, line:Line)
		{
			_polygon = polygon;
			_line = line;
			
			if (_polygon is Mutable || _line is Mutable)
				throw new MutabilityError("The LineAndPolygonIntersection has a Mutable element as definition");

			_vertices = calculateVertices();
		}
		
		public function get vertices():Vector.<Vertex>
		{
			return _vertices;
		}
		
		private function calculateVertices():Vector.<Vertex>
		{
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			var count:int = 0;
			
			var len:int = _polygon.count;
			var b:Vertex = _polygon.get(len - 1);
			for (var i:int = 0; i < len; i++)
			{
				var a:Vertex = _polygon.get(i);
				var edge:ImmutableLine = new ImmutableLine(a, b, LineType.SEGMENT);
				var vertex:Vertex = new ImmutableTwoLinesIntersectionVertex(edge, _line);
				b = a;
				
				if (isNaN(vertex.x) || isNaN(vertex.y))
					continue;
					
				vertices[count++] = vertex;
			}
			
			return vertices;
		}
		
	}
}
