package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.Vertex;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal interface IntersectionOfTwoPolygonsVertex extends Vertex
	{
		
		function set visited(value:Boolean):void;
		
		function get visited():Boolean;
		
		function get isReal():Boolean;
		
		function get positionOnPolygonAAsCycle():Number;
		
		function get positionOnPolygonBAsCycle():Number;
		
	}
}
