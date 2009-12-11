package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ExpandedPolygonVectors 
	{
		private static const NULL_POSITION:int = -1;
		
		private var _a:Polygon;
		private var _aCount:uint;
		
		private var _b:Polygon;
		private var _bCount:uint;
		
		private var _changed:ISignal;
		
		public var polygonA:Array;
		public var polygonB:Array;

		public function ExpandedPolygonVectors(a:Polygon, b:Polygon)
		{
			_a = a;
			_aCount = _a.countVertices;
			
			_b = b;
			_bCount = _b.countVertices;
			
			_changed = new Signal(this, PotentialIntersectionVertex);
			
			populatePolygonA();
			populatePolygonB();
			createIntersections();
		}
		
		private function populatePolygonA():void
		{
			polygonA = [];
			
			for (var i:uint = 0; i < _aCount; i++)
				polygonA.push(new OrignalPolygonVertexWrapper(_a.getVertex(i), i, NULL_POSITION));
		}
		
		private function populatePolygonB():void
		{
			polygonB = [];
			
			for (var i:uint = 0; i < _bCount; i++)
				polygonB.push(new OrignalPolygonVertexWrapper(_b.getVertex(i), NULL_POSITION, i));
		}
		
		private function createIntersections():void
		{
			for (var ai:uint = 0; ai < _aCount; ai++)
			{
				for (var bi:uint = 0; bi < _bCount; bi++)
				{
					var aEdge:Line = _a.getEdge(ai);
					var bEdge:Line = _b.getEdge(bi);
					
					var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(aEdge, bEdge, ai, bi);
					edgeIntersection.realityChanged.add(onRealityOfIntersectionChanged);
				
					polygonA.push(edgeIntersection);
					polygonB.push(edgeIntersection);
				}
			}
		}

		public function addVertexToPolygonA(vertex:Vertex):void
		{
			var ai:uint = _a.indexOfVertex(vertex);
			var aEdge:Line = _a.getEdge(ai);
				
			for (var bi:uint = 0; bi < _bCount; bi++)
			{
				var bEdge:Line = _b.getEdge(bi);
				
				var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(aEdge, bEdge, ai, bi);
			
				polygonA.push(edgeIntersection);
				polygonB.push(edgeIntersection);
			}
		}
		
		public function removeVertexFromPolygonA(vertex:Vertex):void
		{
			stripWrappedVertexFromVector(polygonB, vertex);
			stripIntersectionsWithAGivenVertexFromVector(polygonA, vertex);
			stripIntersectionsWithAGivenVertexFromVector(polygonB, vertex);
		}
		
		public function addVertexToPolygonB(vertex:Vertex):void
		{
			var bi:uint = _b.indexOfVertex(vertex);
			var bEdge:Line = _b.getEdge(bi);
				
			for (var ai:uint = 0; ai < _aCount; ai++)
			{
				var aEdge:Line = _a.getEdge(ai);
				
				var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(aEdge, bEdge, ai, bi);
			
				polygonA.push(edgeIntersection);
				polygonB.push(edgeIntersection);
			}
		}
		
		public function removeVertexFromPolygonB(vertex:Vertex):void
		{
			stripWrappedVertexFromVector(polygonB, vertex);
			stripIntersectionsWithAGivenVertexFromVector(polygonA, vertex);			stripIntersectionsWithAGivenVertexFromVector(polygonB, vertex);
		}
		
		private function stripWrappedVertexFromVector(vector:Array, vertex:Vertex):void
		{
			var i:uint = vector.length;
			while (--i > -1)
			{
				var wrapper:OrignalPolygonVertexWrapper  = polygonB[i] as OrignalPolygonVertexWrapper;
				if (wrapper && wrapper.target == vertex)
				{
					polygonB.splice(i, 1);
					return;
				}
			}
		}
			
		private function stripIntersectionsWithAGivenVertexFromVector(vector:Array, vertex:Vertex):void
		{
			var length:uint = vector.length;
			for (var i:uint = 0; i < length; i++)
			{
				var intersection:PotentialIntersectionVertex = vector[i] as PotentialIntersectionVertex;
				if (intersection && (intersection.a.a == vertex || intersection.a.b == vertex))
				{
					intersection.realityChanged.remove(onRealityOfIntersectionChanged);
					vector.splice(i--, 1);
				}
			}
		}
		
		private function onRealityOfIntersectionChanged(vertex:PotentialIntersectionVertex):void
		{
			_changed.dispatch(vertex);
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
