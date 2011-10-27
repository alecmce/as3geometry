package as3geometry.geom2D.polygons.intersection
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.AbstractMutableAdditiveCollection;
	import as3geometry.geom2D.CollectionOfPolygons;
	import as3geometry.geom2D.Polygon;

	/**
	 * The intersection of two polygons is complex. The aim of the excersize is to not re-evaluate the
	 * entire intersection every time that one of the container polygons is moved; that would take up
	 * too many resources to be practical.
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionOfTwoPolygons extends AbstractMutableAdditiveCollection implements CollectionOfPolygons
	{
		private var _a:Polygon;
		private var _b:Polygon;

		private var _expanded:ExpandedPolygonVectors;
		private var _sorted:SortedPolygonVectors;

		private var _polygonCount:uint;
		private var _polygons:Array;

		public function IntersectionOfTwoPolygons(context:AS3GeometryContext, a:Polygon, b:Polygon)
		{
			super(context, Polygon);

			_a = a;
			_b = b;
			addDefinien(_expanded  = new ExpandedPolygonVectors(context, _a, _b));

			_sorted = new SortedPolygonVectors(context, _expanded);

			_polygons = _sorted.findPolygons();
			_polygonCount = _polygons.length;
		}

		public function get countPolygons():uint
		{
			return _polygonCount;
		}

		public function getPolygon(i:uint):Polygon
		{
			return _polygons[i];
		}

//		private function onExpandedPolygonVectorsChanged(vertex:PotentialIntersectionVertex):void
//		{
//			if (vertex.isReal)
//			{
//
//			}
//			else
//			{
//				var index:int = vertex.polygonIndex;
//				if (index == -1)
//					return;
//
//				var polygon:IntersectionPolygon = _polygons[index];
//				if (polygon)
//				{
//					polygon.removeVertex(vertex);
//					vertex.polygonIndex = -1;
//				}
//			}
//		}

	}
}
