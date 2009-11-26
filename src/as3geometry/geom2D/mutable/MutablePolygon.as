package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutablePolygon extends AbstractMutable implements Polygon, Mutable
	{
		
		private var _vertices:Vector.<Vertex>;

		public function MutablePolygon(vertices:Vector.<Vertex>)
		{
			super();
			
			_vertices = vertices;
			
			var i:int = vertices.length;
			while (--i > -1)
			{
				var v:Vertex = vertices[i];
				addDefinien(v);
			}
		}

		public function get count():int
		{
			return _vertices.length;
		}
		
		public function get(index:int):Vertex
		{
			return _vertices[index];
		}
	}
}
