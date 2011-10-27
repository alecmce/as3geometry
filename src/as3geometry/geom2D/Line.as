package as3geometry.geom2D
{

	/**
	 * Defines a line on a Cartesian plane by two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Line
	{

		function get a():Vertex;

		function get b():Vertex;

		function get vector():SpatialVector;

		function get type():LineType;

	}
}
