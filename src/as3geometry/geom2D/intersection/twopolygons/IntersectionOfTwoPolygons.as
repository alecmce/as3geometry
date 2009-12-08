package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.AbstractMutable;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.mutable.MutablePolygon;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionOfTwoPolygons extends AbstractMutable implements Mutable
	{
		private const NULL_POSITION:int = -1;
		
		private var _a:Polygon;
		private var _aCount:uint;
				private var _b:Polygon;
		private var _bCount:uint;
		
		private var _polygonCount:uint;
		private var _polygons:Vector.<Polygon>;

		private var _vertexCount:uint;		private var _vertices:Vector.<Vertex>;
		
		private var _intersectionTable:Vector.<PolygonsIntersectionVertex>;
		
		private var _augmentedPolygonA:Vector.<IntersectionOfTwoPolygonsVertex>;
		private var _augmentedPolygonALength:uint;
		
		private var _augmentedPolygonB:Vector.<IntersectionOfTwoPolygonsVertex>;
		private var _augmentedPolygonBLength:uint;
		
		public function IntersectionOfTwoPolygons(a:Polygon, b:Polygon)
		{
			super();
			
			addDefinien(_a = a);
			_aCount = _a.count;
						addDefinien(_b = b);
			_bCount = _b.count;
			
			_polygons = new Vector.<Polygon>();
			_polygonCount = 0;
			
			createIntersectionStructures();
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
		
		private function createIntersectionStructures():void
		{
			var len:uint = _aCount * _bCount;
			_intersectionTable = new Vector.<PolygonsIntersectionVertex>(len, true);
			_augmentedPolygonA = new Vector.<IntersectionOfTwoPolygonsVertex>();			_augmentedPolygonB = new Vector.<IntersectionOfTwoPolygonsVertex>();
			
			var ai:uint, bi:uint;
			
			for (ai = 0; ai < _aCount; ai++)				_augmentedPolygonA.push(new PolygonVertexWrapper(_a.getVertex(ai), ai, NULL_POSITION));
			
			for (bi = 0; bi < _bCount; bi++)
				_augmentedPolygonB.push(new PolygonVertexWrapper(_b.getVertex(bi), NULL_POSITION, bi));
			
			for (ai = 0; ai < _aCount; ai++)
			{
				for (bi = 0; bi < _bCount; bi++)
				{
					var aEdge:Line = _a.getEdge(ai);					var bEdge:Line = _b.getEdge(bi);
					
					var edgeIntersection:PolygonsIntersectionVertex = new PolygonsIntersectionVertex(aEdge, bEdge, ai, bi);
					addDefinien(edgeIntersection);
				
					_intersectionTable[bi + ai * _bCount] = edgeIntersection;
					_augmentedPolygonA.push(edgeIntersection);					_augmentedPolygonB.push(edgeIntersection);
				}
			}
		}
		
		private function calculate():void
		{
			_augmentedPolygonA = _augmentedPolygonA.sort(compareFunctionA);
			_augmentedPolygonALength = clearVisitedFlagsAndDetermineLength(_augmentedPolygonA);			
			_augmentedPolygonB = _augmentedPolygonB.sort(compareFunctionB);			_augmentedPolygonBLength = clearVisitedFlagsAndDetermineLength(_augmentedPolygonB);
		
			var intersection:IntersectionOfTwoPolygonsVertex;
			while (intersection = findAnUnvisitedIntersection())
				_polygons[_polygonCount++] = findPolygon(intersection);
		}
		
		private function findAnUnvisitedIntersection():IntersectionOfTwoPolygonsVertex
		{
			for (var i:uint = 0;i < _augmentedPolygonALength; i++)
			{
				var vertex:IntersectionOfTwoPolygonsVertex = _augmentedPolygonA[i];
				if (!vertex.visited && vertex.positionOnPolygonBAsCycle != NULL_POSITION)
					return vertex;
				
				vertex.visited = true;
			}
			
			return null;
		}

		private function findPolygon(intersection:IntersectionOfTwoPolygonsVertex):Polygon
		{
			intersection.visited = true;
			
			var vector:Vector.<IntersectionOfTwoPolygonsVertex> = new Vector.<IntersectionOfTwoPolygonsVertex>();
			vector.push(intersection);
			
			var onBCycle:Boolean = true;
			var i:int = _augmentedPolygonB.indexOf(intersection) - 1;
			if (i < 0)
				i =_augmentedPolygonBLength - 1;
			
			var vertex:IntersectionOfTwoPolygonsVertex = _augmentedPolygonB[i];
			while (vertex != intersection)
			{
				vertex.visited = true;
				vector.push(vertex);
				
				if (onBCycle)
				{
					onBCycle = !(vertex.positionOnPolygonAAsCycle > NULL_POSITION);
					if (onBCycle)
					{
						i--;
						if (i < 0)
							i = _augmentedPolygonBLength - 1;
					}
					else
					{
						i = _augmentedPolygonA.indexOf(vertex) - 1;
						if (i < 0)
							i = _augmentedPolygonALength - 1;
					}
				}
				else
				{
					onBCycle = vertex.positionOnPolygonBAsCycle > NULL_POSITION;
					if (onBCycle)
					{
						i = _augmentedPolygonB.indexOf(vertex) - 1;
						if (i == 0)
							i = _augmentedPolygonBLength - 1;
					}
					else
					{
						i--;
						if (i < 0)
							i = _augmentedPolygonALength - 1;
					}
				}
				
				vertex = onBCycle ? _augmentedPolygonB[i] : _augmentedPolygonA[i];
			}
			
			return new MutablePolygon(Vector.<Vertex>(vector));
		}

		private function clearVisitedFlagsAndDetermineLength(vector:Vector.<IntersectionOfTwoPolygonsVertex>):uint
		{
			var length:uint = vector.length;
			
			var i:uint = 0;
			while (i < length && vector[i].isReal)
				vector[i++].visited = false;
			
			var functionalLength:uint = i;
			
			while (i < length)
				vector[i++].visited = true;
				
			return functionalLength;			
		}

		private function compareFunctionA(a:IntersectionOfTwoPolygonsVertex, b:IntersectionOfTwoPolygonsVertex):int
		{
			var ai:Number = a.positionOnPolygonAAsCycle;			var bi:Number = b.positionOnPolygonAAsCycle;
			
			if (isNaN(ai))
				return isNaN(bi) ? 0 : 1;
			else if (isNaN(bi))
				return -1;
			else
				return ai < bi ? -1 : ai > bi ? 1 : 0;
		}
		
		private function compareFunctionB(a:IntersectionOfTwoPolygonsVertex, b:IntersectionOfTwoPolygonsVertex):int
		{
			var ai:Number = a.positionOnPolygonBAsCycle;
			var bi:Number = b.positionOnPolygonBAsCycle;
			
			if (isNaN(ai))
				return isNaN(bi) ? 0 : 1;
			else if (isNaN(bi))
				return -1;
			else
				return ai < bi ? -1 : ai > bi ? 1 : 0;
		}
		
		override protected function onDefinienChanged(mutable:Mutable):void
		{
			super.onDefinienChanged(mutable);
			
			var vertex:PolygonsIntersectionVertex = PolygonsIntersectionVertex(mutable);
			if (vertex && vertex.hasRealValueChanged)
				trace("ch ch ch ch changing!");
		}
		
	}
}
