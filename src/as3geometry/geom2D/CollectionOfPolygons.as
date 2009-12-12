package as3geometry.geom2D 
{
	

	/**
	 * Describes a collection of polygons
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface CollectionOfPolygons
	{
		
		function get countPolygons():uint;
		
		function getPolygon(index:uint):Polygon;
		
	}
}
