package as3geometry.geom2D 
{
	

	/**
	 * Describes a collection of vertices
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface CollectionOfVertices
	{
		
		function get countVertices():uint;
		
		function getVertex(index:uint):Vertex;
		
		function indexOfVertex(vertex:Vertex):int;
		
	}
}
