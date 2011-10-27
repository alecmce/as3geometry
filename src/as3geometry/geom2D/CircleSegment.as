package as3geometry.geom2D
{

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface CircleSegment
	{

		function get from():VertexOnCircle;

		function get to():VertexOnCircle;

		function get angle():Number;

	}
}
