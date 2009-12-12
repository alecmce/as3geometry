package as3geometry.geom2D 
{

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface VertexOnLine extends Vertex
	{
		
		function get line():Line;
		
		function get positionOnLineAsMultiplier():Number;
		
	}
}
