package as3geometry.geom2D 
{

	/**
	 * Defines a vertex on a cartesian plane.
	 * 
	 * Vertex is preferred instead of flash.geom.Point because the Vertex class
	 * is immutable.
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Vertex 
	{
		
		function get x():Number;
		
		function get y():Number;
		
	}
}
