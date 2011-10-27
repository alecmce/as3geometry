package as3geometry.geom2D.polygons.intersection
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	/**
	 * ExpandedPolygonVectors creates two Arrays containing wrappers for the
	 * definien vertices as well as potential intersection vertices for each
	 * vertex which could potentially be an intersection between a line
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ExpandedPolygonVectors extends Mutable
	{
		private static const NULL_POSITION:int = -1;

		private var _a:Polygon;
		private var _aCount:uint;

		private var _b:Polygon;
		private var _bCount:uint;

		// TODO can this easily be converted to Vector.<ExpandedPolygonVertex>?
		public var polygonA:Array;

		// TODO can this easily be converted to Vector.<ExpandedPolygonVertex>?
		public var polygonB:Array;

		public function ExpandedPolygonVectors(context:AS3GeometryContext, a:Polygon, b:Polygon)
		{
			super(context);

			addDefinien(_a = a);
			_aCount = _a.countVertices;

			addDefinien(_b = b);
			_bCount = _b.countVertices;

			populatePolygonA();
			populatePolygonB();
			createIntersections();
		}

		/**
		 * create a wrapper for each vertex in polygon A
		 */
		private function populatePolygonA():void
		{
			polygonA = [];

			for (var i:uint = 0; i < _aCount; i++)
				polygonA.push(new OrignalPolygonVertexWrapper(_a.getVertex(i), i, NULL_POSITION));
		}

		/**
		 * create a wrapper for each vertex in polygon B
		 */
		private function populatePolygonB():void
		{
			polygonB = [];

			for (var i:uint = 0; i < _bCount; i++)
				polygonB.push(new OrignalPolygonVertexWrapper(_b.getVertex(i), NULL_POSITION, i));
		}

		/**
		 * create a potential intersection for each pair of polygon edges
		 */
		private function createIntersections():void
		{
			var context:AS3GeometryContext = this.context;

			for (var ai:uint = 0; ai < _aCount; ai++)
			{
				for (var bi:uint = 0; bi < _bCount; bi++)
				{
					var aEdge:Line = _a.getEdge(ai);
					var bEdge:Line = _b.getEdge(bi);

					var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(context, aEdge, bEdge, ai, bi);
					edgeIntersection.realityChanged.add(onRealityOfIntersectionChanged);

					polygonA.push(edgeIntersection);
					polygonB.push(edgeIntersection);
				}
			}
		}

		public function addVertexToPolygonA(vertex:Vertex):void
		{
			var context:AS3GeometryContext = this.context;

			var ai:uint = _a.indexOfVertex(vertex);
			var aEdge:Line = _a.getEdge(ai);

			for (var bi:uint = 0; bi < _bCount; bi++)
			{
				var bEdge:Line = _b.getEdge(bi);

				var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(context, aEdge, bEdge, ai, bi);

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
			var context:AS3GeometryContext = this.context;

			var bi:uint = _b.indexOfVertex(vertex);
			var bEdge:Line = _b.getEdge(bi);

			for (var ai:uint = 0; ai < _aCount; ai++)
			{
				var aEdge:Line = _a.getEdge(ai);

				var edgeIntersection:PotentialIntersectionVertex = new PotentialIntersectionVertex(context, aEdge, bEdge, ai, bi);

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
			invalidate();
		}

	}
}
