package as3geometry.geom2D.minimal 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a line on a Cartesian plane by two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MinimalLine implements Line
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the line */
		private var a_:Vertex;
		
		/** a vertex of the line */
		private var b_:Vertex;
		
		private var vector_:SpatialVector;
		
		/** the line type */
		private var type_:LineType;
		
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		/**
		 * Class Constructor
		 * 
		 * @param a A vertex of the line
		 * @param b A vertex of the line
		 */
		public function MinimalLine(a:Vertex = null, b:Vertex = null, type:LineType = null)
		{
			a_ = a ? a : new MinimalVertex(0, 0);
			b_ = b ? b : new MinimalVertex(0, 0);
			type_ = type ? type : LineType.LINE;
		}

		
		public function get a():Vertex
		{
			return a_;
		}
		
		
		public function get b():Vertex
		{
			return b_;
		}
		
		
		public function get vector():SpatialVector
		{
			if (!vector_)
				vector_ = new MinimalSpatialVector(b_.x - a_.x, b_.y - a_.y);
			
			return vector_;
		}
		
		
		public function get type():LineType
		{
			return type_;
		}
		
		
		/**
		 * determine whether two lines are the same iff they share the same
		 * determinant vertices
		 * 
		 * @param line The line to compare this line with
		 * @return Whether the two lines are the same
		 */
		public function isSame(line:Line):Boolean
		{
			return (a == line.a && b == line.b) || (a == line.b && b == line.a);
		}
		
		
		/**
		 * @return A user-readable string describing this line
		 */
		public function toString():String
		{
			return "[LINE " + a + ", " + b + "]";
		}
		
	}
}
