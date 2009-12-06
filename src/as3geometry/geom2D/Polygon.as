package as3geometry.geom2D 
{

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Polygon 
	{
		
		function get count():uint;
		
		function getVertex(index:uint):Vertex;
		
		function getEdge(index:uint):Line;
		
		function contains(vertex:Vertex):Boolean;
		
	}
}
