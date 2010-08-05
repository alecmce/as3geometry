package as3geometry.geom2D 
{

	/**
	 * Defines a parabola defined geometrically as the locus of points equidistant
	 * to a point and a line (where the distance from a point to a line is taken
	 * as the shortest distance; the distance of the perpendicular from the line
	 * to the point)
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Parabola 
	{
		
		function get focus():Vertex;
		
		function get directrix():Line;
		
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
		function getVertex(n:Number):Vertex;
		
	}
}
