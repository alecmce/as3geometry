package as3geometry.geom2D.parabola 
{
	import as3geometry.abstract.Mutable;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a parabola defined geometrically as the locus of points equidistant
	 * to a point and a line
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableParabola implements Parabola 
	{
		private var _focus:Vertex;
		private var _directrix:Line;

		/**
		 * Class Constructor
		 * 
		 * @param focus The 
		 */
		public function ImmutableParabola(focus:Vertex, directrix:Line) 
		{
			if (focus is Mutable)
				throw new MutabilityError("A vertex defining an ImmutableParabola is Mutable");
			else
				_focus = focus;
			
			if (directrix is Mutable)
				throw new MutabilityError("A line defining an ImmutableParabola is Mutable");
			else
				_directrix = directrix;
		}

		public function get focus():Vertex
		{
			return _focus;
		}
		
		public function get directrix():Line
		{
			return _directrix;
		}
		
		/**
		 * A parabola's vertices can be enumerated with respect to the vertex that
		 * lies perpendicular to them on the directrix.
		 * 
		 * @param n A position on the directrix such that 0 is on directrix.a and
		 *  1 is on directrix.b. The range of values that are appropriate is
		 *  contingent upon the LineType of the Line.
		 *  
		 * @return The vertex that lies perpendicular to the directrix such that
		 * the vertex defined by n on the directrix is the intersection of the
		 * directrix and the perpendicular line
		 */
		public function getVertex(n:Number):Vertex
		{
			return null;
		}
	}
}
