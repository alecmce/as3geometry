package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.util.PolygonHelper;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class SortedPolygonVectors 
	{
		private const NULL_POSITION:int = -1;
		
		private var helper:PolygonHelper;
		
		private var expanded:ExpandedPolygonVectors;
		
		public var polygonA:Array;
		public var isAClockwise:Boolean;		public var aLength:uint;
		
		public var polygonB:Array;
		public var isBClockwise:Boolean;
		public var bLength:uint;
		
		public function SortedPolygonVectors(expanded:ExpandedPolygonVectors)
		{
			helper = new PolygonHelper();
			
			this.expanded = expanded;
			
			polygonA = expanded.polygonA.sort(compareFunctionA);
			aLength = getLengthOfNonNullList(polygonA);			isAClockwise = helper.isVertexPolygonClockwise(polygonA, aLength);
						polygonB = expanded.polygonB.sort(compareFunctionB);
			bLength = getLengthOfNonNullList(polygonB);
			isBClockwise = helper.isVertexPolygonClockwise(polygonB, bLength);
		}
		
		public function findPolygons():Array
		{
			var polygons:Array = [];
			var count:uint = 0;
			
			var intersection:ExpandedPolygonVertex;
			while (intersection = findAnUnvisitedIntersection())
				polygons[count] = findPolygon(intersection, count++);
			
			return polygons;
		}

		private function findAnUnvisitedIntersection():ExpandedPolygonVertex
		{
			for (var i:uint = 0; i < aLength; i++)
			{
				var vertex:ExpandedPolygonVertex = polygonA[i];
				var isVertexVisited:Boolean = vertex.visited;
				
				vertex.visited = true;
				
				if (!isVertexVisited && vertex.positionOnPolygonBAsCycle != NULL_POSITION)
					return vertex;
			}
			
			return null;
		}

		private function findPolygon(intersection:ExpandedPolygonVertex, polygonIndex:int):IntersectionPolygon
		{
			intersection.visited = true;
			
			var vector:Array = [];
			vector.push(intersection);
			
			var aDirection:int = -1;
			var bDirection:int = isAClockwise == isBClockwise ? -1 : 1;
			
			var onBCycle:Boolean = true;
			var i:int = polygonB.indexOf(intersection) + bDirection;
			if (i == NULL_POSITION)
				i = bLength - 1;
			else if (i == bLength)
				i = 0;
			
			var vertex:ExpandedPolygonVertex = polygonB[i];
			while (vertex != intersection)
			{
				vertex.visited = true;
				vertex.polygonIndex = polygonIndex;
				vector.push(vertex);
				
				if (onBCycle)
				{
					onBCycle = !(vertex.positionOnPolygonAAsCycle > NULL_POSITION);
					if (onBCycle)
					{
						i += bDirection;
						if (i == -1)
							i = bLength - 1;
						else if (i == bLength)
							i = 0;
					}
					else
					{
						i = polygonA.indexOf(vertex) + aDirection;
						if (i == -1)
							i = aLength - 1;
						else if (i == aLength)
							i = 0;
					}
				}
				else
				{
					onBCycle = vertex.positionOnPolygonBAsCycle > NULL_POSITION;
					if (onBCycle)
					{
						i = polygonB.indexOf(vertex) + bDirection;
						if (i == -1)
							i = bLength - 1;
						else if (i == bLength)
							i = 0;
					}
					else
					{
						i += aDirection;
						if (i == -1)
							i = aLength - 1;
						else if (i == aLength)
							i = 0;
					}
				}
				
				vertex = onBCycle ? polygonB[i] : polygonA[i];
			}
			
			return new IntersectionPolygon(vector);
		}

		public function clearVisitedFlags(vector:Array):void
		{
			var length:uint = vector.length;
			
			var i:uint = 0;
			while (i < length && vector[i].isReal)
				vector[i++].visited = false;
			
			while (i < length)
				vector[i++].visited = true;
		}
		
		private function getLengthOfNonNullList(vector:Array):uint
		{
			var length:uint = vector.length;
			
			var i:uint = 0;
			while (i < length && vector[i].isReal)
				i++;
			
			return i;
		}
		
		private function compareFunctionA(a:ExpandedPolygonVertex, b:ExpandedPolygonVertex):int
		{
			var ai:Number = a.positionOnPolygonAAsCycle;
			var bi:Number = b.positionOnPolygonAAsCycle;
			
			if (isNaN(ai))
				return isNaN(bi) ? 0 : 1;
			else if (isNaN(bi))
				return -1;
			else
				return ai < bi ? -1 : ai > bi ? 1 : 0;
		}
		
		private function compareFunctionB(a:ExpandedPolygonVertex, b:ExpandedPolygonVertex):int
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
	}
}
