package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.intersection.twopolygons.IntersectionOfTwoPolygons;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutablePolygon;
	import as3geometry.geom2D.immutable.ImmutableVertex;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;

	public class IntersectionOfTwoPolygonsTest 
	{
		private var a:Polygon;			private var b:Polygon;
		
		private var intersections:IntersectionOfTwoPolygons;

		[After]
		public function tearDown():void
		{
			a = null;
			b = null;
			intersections = null;
		}
		
		[Test]
		public function twoSquares():void
		{
			var vertices:Vector.<Vertex>;
			
			vertices = new Vector.<Vertex>(4);
			vertices[0] = new ImmutableVertex(0, 0);
			vertices[1] = new ImmutableVertex(10, 0);
			vertices[2] = new ImmutableVertex(10, 10);
			vertices[3] = new ImmutableVertex(0, 10);
			
			a = new ImmutablePolygon(vertices);
			
			vertices = new Vector.<Vertex>(4);
			vertices[0] = new ImmutableVertex(5, 5);
			vertices[1] = new ImmutableVertex(15, 5);
			vertices[2] = new ImmutableVertex(15, 15);
			vertices[3] = new ImmutableVertex(5, 15);
			
			b = new ImmutablePolygon(vertices);
		
			intersections = new IntersectionOfTwoPolygons(a, b);
			
			assertEquals(1, intersections.polygonCount);
			
			var polygon:Polygon = intersections.get(0);
			
			assertEquals(4, polygon.count);
			assertTrue(polygon, "0,0 5,0 5,5 0,5");
		}

		[Test]
		public function testPolygonComparisonRoutine():void
		{
			var vertices:Vector.<Vertex>;
			
			vertices = new Vector.<Vertex>(4);			vertices[0] = new ImmutableVertex(0, 0);			vertices[1] = new ImmutableVertex(5, 0);			vertices[2] = new ImmutableVertex(5, 5);			vertices[3] = new ImmutableVertex(0, 5);
			
			a = new ImmutablePolygon(vertices);
			assertPolygonEquals(a, "0,0 5,0 5,5 0,5");
			
			vertices = new Vector.<Vertex>(4);
			vertices[0] = new ImmutableVertex(0, 1);
			vertices[1] = new ImmutableVertex(5, 0);
			vertices[2] = new ImmutableVertex(5, 5);
			vertices[3] = new ImmutableVertex(0, 5);
			
			a = new ImmutablePolygon(vertices);
			assertPolygonNotEquals(a, "0,0 5,0 5,5 0,5");
		}
		
		
		/*********************************************************************/
		// Utility Methods
		/*********************************************************************/
		
		
		private function assertPolygonEquals(polygon:Polygon, test:String):void
		{
			if (compare(polygon, test))
				assertTrue(true);
			else
				fail("assertPolygonEquals failed");
		}
		
		private function assertPolygonNotEquals(polygon:Polygon, test:String):void
		{
			if (!compare(polygon, test))
				assertTrue(true);
			else
				fail("assertPolygonNotEquals failed");
		}
		
		private function compare(polygon:Polygon, test:String):Boolean
		{
			var vertices:Array = test.split(" ");
			var matches:Array = [];
			for (var i:int = 0; i < vertices.length; i++)
			{
				var tmp:Array = vertices[i].split(",");
				var x:Number = tmp[0];
				var y:Number = tmp[1];
				
				var j:int = polygon.count;
				var match:Boolean = false;
				while (j-- && !match)
				{
					if (matches.indexOf(j) == -1)
					{
						var vertex:Vertex = polygon.getVertex(j);
						match = vertex.x == x && vertex.y == y;
					}
				}
				
				if (!match)
					return false;
			}
			
			return true;
		}
		
		
	}
}
