package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutablePolygon implements Polygon
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the line */
		private var vertices:Vector.<Vertex>;
				
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/

		
		/**
		 * Class Constructor
		 * 
		 * @param vertices The array of vertices that defines the polygon
		 */
		public function ImmutablePolygon(vertices:Vector.<Vertex>)
		{
			this.vertices = vertices;
			
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
		public function get count():int
		{
			return vertices.length;
		}
		
		
		/**
		 * retrieve the vertex at a given index
		 * 
		 * @param index The index of the vertex to be retrieved
		 * 
		 * @return The vertex at the corresponding index
		 */
		public function get(index:int):Vertex
		{
			return vertices[index];
		}
		
		
	}
}
