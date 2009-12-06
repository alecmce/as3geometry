package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.AbstractMutable;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionOfTwoPolygons extends AbstractMutable implements Mutable
	{
		private var _a:Polygon;
		private var _aCount:uint;
				private var _b:Polygon;
		private var _bCount:uint;
		
		private var _polygonCount:uint;
		private var _polygons:Vector.<Polygon>;

		private var _vertexCount:uint;		private var _vertices:Vector.<Vertex>;
		
		private var _intersectionTable:Vector.<IntersectionOfTwoLinesVertex>;
		
		public function IntersectionOfTwoPolygons(a:Polygon, b:Polygon)
		{
			super();
			
			addDefinien(_a = a);
			_aCount = _a.count;
						addDefinien(_b = b);
			_bCount = _b.count;
			
			createIntersectionTable();
			calculate();
		}

		public function get polygonCount():uint
		{
			return _polygonCount;
		}
		
		public function get(i:uint):Polygon
		{
			return _polygons[i];
		}
		
		public function get vertexCount():uint
		{
			return _vertexCount;
		}
		
		public function getVertex(i:uint):Vertex
		{
			return _vertices[i];
		}
		
		private function createIntersectionTable():void
		{
			var len:uint = _aCount * _bCount;
			_intersectionTable = new Vector.<TwoPolygonsVertex>(true, len);
			
			for (var ai:uint = 0; ai < _aCount; ai++)
			{
				for (var bi:uint = 0; bi < _bCount; bi++)
				{
					var aEdge:Line = _a.getEdge(ai);					var bEdge:Line = _b.getEdge(bi);
					
					var intersection:TwoPolygonsVertex = new TwoPolygonsVertex(aEdge, bEdge);
					addDefinien(intersection);
				
					_intersectionTable[ai + bi * _aCount] = intersection;
				}
			}
		}
		
		private function intersectionsForEdgeInPolygonA(index:uint):Vector.<uint>
		{
			var indices:Vector.<uint> = new Vector.<uint>();
			
			
			
			return indices;
		}
		
		
		private function calculate():void
		{
			var aIndex:uint = 0;
			
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			super.onDefinienChanged(mutable);
			
			var vertex:TwoPolygonsVertex = TwoPolygonsVertex(mutable);
			if (vertex && vertex.isIntersectionChanged)
				trace("ch ch ch ch changing!");
		}
		
	}
}
