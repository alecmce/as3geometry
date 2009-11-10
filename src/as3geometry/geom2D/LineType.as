package as3geometry.geom2D 
{

	/**
	 * An enumeration of line types:
	 * 
	 * A LINE extends infinitely in both directions from the two definitional vertices
	 * 
	 * A RAY starts at Vertex a and extends infinitely through Vertex b
	 * 
	 * A SEGMENT starts at Vertex a and stops at Vertex b
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class LineType 
	{
		
		public static const LINE:LineType = new LineType();
		
		public static const RAY:LineType = new LineType();
		
		public static const SEGMENT:LineType = new LineType();
		
		
	}
}
