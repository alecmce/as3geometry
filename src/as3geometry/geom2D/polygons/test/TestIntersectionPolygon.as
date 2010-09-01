package as3geometry.geom2D.polygons.test
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	
	/**
	 * @author amceachran
	 */
	public class TestIntersectionPolygon extends Mutable implements Polygon
	{
		
		private var _potentialVertices:Array;
		private var _potentialLines:Array;
		
		private var _actualVertices:Array;
		private var _actualLines:Array;
		
		public function TestIntersectionPolygon(context:AS3GeometryContext, vertices:Array)
		{
			super(context);
			
			_potentialVertices = vertices;
			
			var len:int = vertices.length;
			for (var i:int = 0; i < len; i++)
			{
				var v:Vertex = vertices[i];
				if (v is PotentialIntersectionVertex)
					PotentialIntersectionVertex(v).realityChanged.add(onRealityChanged);
			}
		}

		private function onRealityChanged(vertex:PotentialIntersectionVertex):void
		{
			
			
			invalidate();
		}
		
		public function getEdge(index:uint):Line
		{
			// TODO: Auto-generated method stub
			return null;
		}

		public function contains(vertex:Vertex):Boolean
		{
			// TODO: Auto-generated method stub
			return null;
		}

		public function getVertex(index:uint):Vertex
		{
			// TODO: Auto-generated method stub
			return null;
		}

		public function indexOfVertex(vertex:Vertex):int
		{
			// TODO: Auto-generated method stub
			return 0;
		}

		public function get countVertices() : uint
		{
			// TODO: Auto-generated method stub
			return 0;
		}
	}
}
