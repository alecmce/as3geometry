package as3geometry.geom2D.ui 
{
	import as3geometry.AdditiveCollection;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.CollectionOfPolygons;

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
			addAdditiveListeners(_polygons);
			
			_drawers = new Dictionary();
			
			super(paint);
			generateDrawersForExistingPolygons();
		}
		

		private function generateDrawersForExistingPolygons():void
		{
			var i:uint = _polygons.countPolygons;
			while (--i > -1)
			{
				var polygon:Polygon = _polygons.getPolygon(i);
				createPolygonDrawer(polygon);
			}
		}
		
		private function addAdditiveListeners(polygons:CollectionOfPolygons):void
		{
			var additive:AdditiveCollection = polygons as AdditiveCollection;
			if (!additive)
				return;
			
			additive.added.add(onPolygonAdded);
			additive.removed.add(onPolygonRemoved);
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
