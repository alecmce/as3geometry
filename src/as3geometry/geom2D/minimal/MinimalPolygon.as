package as3geometry.geom2D.minimal 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MinimalPolygon implements Polygon
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
		public function MinimalPolygon(vertices:Vector.<Vertex>)
		{
			this.vertices = vertices;
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
