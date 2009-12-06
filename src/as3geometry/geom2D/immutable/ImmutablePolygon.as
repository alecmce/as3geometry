package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.util.PolygonHelper;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutablePolygon implements Polygon
	{
		private var _vertices:Vector.<Vertex>;
		
		private var _edges:Vector.<Line>;
				
		/**
		 * Class Constructor
		 * 
		 * @param vertices The array of vertices that defines the polygon
		 */
		public function ImmutablePolygon(vertices:Vector.<Vertex>)
		{
			_vertices = vertices.concat();
			_edges = new Vector.<Line>(vertices.length, true);
			
			var i:int = vertices.length;
			while (--i > -1)
			{
				var v:Vertex = vertices[i];
				if (v is Mutable)
					throw new MutabilityError("A point defining a ImmutablePolygon is mutable");
			}
		}

		
		/**
		 * @return The number of vertices in the polygon
		 */
		public function get count():uint
		{
			return _vertices.length;
		}
		
		
		/**
		 * retrieve the vertex at a given index
		 * 
		 * @param index The index of the vertex to be retrieved
		 * 
		 * @return The vertex at the corresponding index
		 */
		public function getVertex(index:uint):Vertex
		{
			return _vertices[index];
		}
		
		/**
		 * get the edge of the polygon at a given index
		 * 
		 * I've adopted a strategay of just-in-time referencing of the ImmutablePolygon edges as
		 * I anticipate in many cases they will not need to be defined
		 */
		public function getEdge(index:uint):Line
		{
			var edge:Line = _edges[index];
			if (edge == null)
			{
				var a:Vertex = getVertex(index);
				var b:Vertex = getVertex(index + 1 == _vertices.length ? 0 : index + 1);
				_edges[index] = edge = new ImmutableLine(a, b, LineType.SEGMENT);
			}
			
			return edge;
		}
		
		public function contains(vertex:Vertex):Boolean
		{
			var helper:PolygonHelper = new PolygonHelper();
			return helper.vertexPolygonContains(_vertices, vertex);
		}
	}
}
