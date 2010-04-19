package as3geometry.geom2D.line 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.vectors.ImmutableSpatialVector;
	import as3geometry.geom2D.vertices.ImmutableVertex;

	/**
	 * Defines a line on a Cartesian plane by two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableLine implements Line
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the line */
		private var _a:Vertex;
		
		/** a vertex of the line */
		private var _b:Vertex;
		
		/** the line type */
		private var _type:LineType;
		
		private var _vector:SpatialVector;
		
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		/**
		 * Class Constructor
		 * 
		 * @param a A vertex of the line
		 * @param b A vertex of the line
		 */
		public function ImmutableLine(a:Vertex = null, b:Vertex = null, type:LineType = null)
		{
			_a = a ? a : new ImmutableVertex(0, 0);
			_b = b ? b : new ImmutableVertex(0, 0);
			_type = type ? type : LineType.LINE;
			
			if (_a is Mutable || _b is Mutable)
				throw new MutabilityError("One of the ImmutableLine's definitional points is mutable");
		}

		
		public function get a():Vertex
		{
			return _a;
		}
		
		
		public function get b():Vertex
		{
			return _b;
		}
		
		
		public function get vector():SpatialVector
		{
			if (!_vector)
				_vector = new ImmutableSpatialVector(_b.x - _a.x, _b.y - _a.y);
			
			return _vector;
		}
		
		
		public function get type():LineType
		{
			return _type;
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
