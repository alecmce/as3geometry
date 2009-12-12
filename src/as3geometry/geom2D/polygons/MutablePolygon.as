package as3geometry.geom2D.polygons 
{
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.Mutable;
	import as3geometry.abstract.AbstractMutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.util.PolygonHelper;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutablePolygon extends AbstractMutable implements Polygon, Mutable
	{
		
		protected var _vertices:Array;
		
		private var _edges:Array;
		
		public function MutablePolygon(vertices:Array)
		{
			super();
			
			_vertices = vertices.concat();
			_edges = [];
			
			var i:int = vertices.length;
			while (--i > -1)
			{
				var v:Vertex = vertices[i];
				addDefinien(v);
			}
		}

		public function get countVertices():uint
		{
			return _vertices.length;
		}
		
		public function getVertex(index:uint):Vertex
		{
			return _vertices[index];
		}
		
		/**
		 * get the edge of the polygon at a given index
		 * 
		 * I've adopted a strategay of just-in-time referencing of the MutablePolygon edges;
		 * The mutability of the polygon means that the edges are fixed once defined (in case
		 * a vertex is defined on it or as an intersection with it and another item) it cannot
		 * be disposed and re-generated later-on
		 */
		public function getEdge(index:uint):Line
		{
			var edge:Line = _edges[index];
			if (edge == null)
			{
				var a:Vertex = getVertex(index);
				var b:Vertex = getVertex(index + 1 == _vertices.length ? 0 : index + 1);
				_edges[index] = edge = new MutableLine(a, b, LineType.SEGMENT);
			}
			
			return edge;
		}
		
		public function contains(vertex:Vertex):Boolean
		{
			var helper:PolygonHelper = new PolygonHelper();
			return helper.vertexPolygonContains(_vertices, vertex);
		}
		
		public function indexOfVertex(vertex:Vertex):int
		{
			return _vertices.indexOf(vertex);
		}
	}
}
