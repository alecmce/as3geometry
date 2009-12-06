package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.MutableVertex;

	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;

	public class ImmutablePolygonTest
	{
		private var polygon:ImmutablePolygon;
		
		[After]
		public function tearDown():void
		{
			polygon = null;
		}
		
		[Test]
		public function mutableErrorIsThrown():void
		{
			var a:MutableVertex = new MutableVertex(1,0);
			var b:ImmutableVertex = new ImmutableVertex(1,1);			var c:ImmutableVertex = new ImmutableVertex(0,1);			var d:ImmutableVertex = new ImmutableVertex(0,0);			
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			vertices[0] = a;			vertices[1] = b;			vertices[2] = c;			vertices[3] = d;
			
			try
			{
				polygon = new ImmutablePolygon(vertices);
			}
			catch (error:MutabilityError)
			{
				return;
			}
			
			fail("ImmutablePolygon should throw a mutability error if a mutable vertex is used as a defining point");
		}
		
		[Test]
		public function polygonContainsVertex():void
		{
			var polygon:Polygon = constructSquare();
			assertTrue(polygon.contains(new ImmutableVertex(5, 5)));
		}
		
		[Test]
		public function polygonContainsVertexOnEdge():void
		{
			var polygon:Polygon = constructSquare();
			assertTrue(polygon.contains(new ImmutableVertex(10, 5)));
		}

		[Test]
		public function polygonContainsVertexOnOtherEdge():void
		{
			var polygon:Polygon = constructSquare();
			assertTrue(polygon.contains(new ImmutableVertex(0, 5)));
		}
		
		[Test]
		public function polygonContainsVertexAtVertex():void
		{
			var polygon:Polygon = constructSquare();
			assertTrue(polygon.contains(new ImmutableVertex(0, 0)));
		}
		
		[Test]
		public function polygonContainsVertexAtOtherVertex():void
		{
			var polygon:Polygon = constructSquare();
			assertTrue(polygon.contains(new ImmutableVertex(10, 10)));
		}
		
		[Test]
		public function polygonDoesntContainVertex():void
		{
			var polygon:Polygon = constructSquare();
			assertFalse(polygon.contains(new ImmutableVertex(11, 5)));
		}
		
		[Test]
		public function polygonDoesntContainAnotherVertex():void
		{
			var polygon:Polygon = constructSquare();
			assertFalse(polygon.contains(new ImmutableVertex(5, 11)));
		}
		
		private function constructSquare():Polygon
		{
			var a:ImmutableVertex = new ImmutableVertex(10,0);
			var b:ImmutableVertex = new ImmutableVertex(10,10);
			var c:ImmutableVertex = new ImmutableVertex(0,10);
			var d:ImmutableVertex = new ImmutableVertex(0,0);
			
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			vertices[0] = a;
			vertices[1] = b;
			vertices[2] = c;
			vertices[3] = d;
			
			return new ImmutablePolygon(vertices);
		}
		
	}
}
