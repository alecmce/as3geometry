package as3geometry.geom2D.collections 
{
	import as3geometry.geom2D.Polygon;

	/**
	 * Describes a collection of polygons
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface CollectionOfPolygons extends AbstractGeometricalCollection
	{
		
		function getPolygon(index:uint):Polygon;
		
	}
}
