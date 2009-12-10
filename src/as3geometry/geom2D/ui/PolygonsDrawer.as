package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.collections.CollectionOfPolygons;

	import ui.Paint;

	import flash.utils.Dictionary;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonsDrawer extends GeneralDrawer
	{
		
		private var _polygons:CollectionOfPolygons;

		private var _drawers:Dictionary;
		
		public function PolygonsDrawer(polygons:CollectionOfPolygons, paint:Paint = null)
		{
			_polygons = polygons;
			_polygons.added.add(onPolygonAdded);			_polygons.removed.add(onPolygonRemoved);
			
			_drawers = new Dictionary();
			
			super(paint);
			generateDrawersForExistingPolygons();
		}
		
		private function generateDrawersForExistingPolygons():void
		{
			var i:uint = _polygons.count;
			while (--i > -1)
			{
				var polygon:Polygon = _polygons.getPolygon(i);
				createPolygonDrawer(polygon);
			}
		}

		private function onPolygonAdded(polygon:Polygon):void
		{
			createPolygonDrawer(polygon);
		}
		
		private function onPolygonRemoved(polygon:Polygon):void
		{
			var drawer:PolygonDrawer = _drawers[polygon];
			if (!drawer)
				return;
			
			removeChild(drawer);
			delete _drawers[polygon];
		}
		
		private function createPolygonDrawer(polygon:Polygon):void
		{
			var drawer:PolygonDrawer = new PolygonDrawer(polygon, _paint);
			
			addChild(drawer);
			_drawers[polygon] = drawer;
		}
	}
}
