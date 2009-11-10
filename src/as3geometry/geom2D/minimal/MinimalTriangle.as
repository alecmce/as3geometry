package as3geometry.geom2D.minimal 
{
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a triangle on a Cartesian plane by three vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MinimalTriangle implements Triangle
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the triangle */
		private var a_:Vertex;
				/** a vertex of the triangle */
		private var b_:Vertex;
				/** a vertex of the triangle */
		private var c_:Vertex;
		
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		public function MinimalTriangle(a:Vertex = null, b:Vertex = null, c:Vertex = null)
		{
			this.a_ = a ? a : new MinimalVertex(0, 0);			this.b_ = b ? b : new MinimalVertex(0, 0);			this.c_ = c ? c : new MinimalVertex(0, 0);
		}
		
		public function get a():Vertex
		{
			return a_;
		}
		
		public function get b():Vertex
		{
			return b_;
		}
		
		public function get c():Vertex
		{
			return c_;
		}

		public function toString():String
		{
			return "[TRIANGLE " + a_ + ", " + b_ + ", " + c_ + "]";
		}
		
		
	}
}
