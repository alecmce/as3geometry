package as3geometry.geom2D.immutable
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.polygons.ImmutablePolygon;
	import as3geometry.geom2D.vertices.ImmutableVertex;
	import as3geometry.geom2D.vertices.IndependentVertex;

	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;

	import flash.display.Sprite;

	public class ImmutablePolygonTest
	{
		[Inject]
		public var sprite:Sprite;

		private var polygon:ImmutablePolygon;
		private var context:AS3GeometryContext;

		[Before]
		public function setup():void
		{
			context = new AS3GeometryContext(sprite);
		}

		[After]
		public function tearDown():void
		{
			polygon = null;
		}

		[Test]
		public function mutableErrorIsThrown():void
		{
			var a:IndependentVertex = new IndependentVertex(context, 1, 0);
			var b:ImmutableVertex = new ImmutableVertex(1, 1);			var c:ImmutableVertex = new ImmutableVertex(0, 1);			var d:ImmutableVertex = new ImmutableVertex(0, 0);
			var vertices:Array = [a,b,c,d];

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

			var vertices:Array = [a,b,c,d];
			return new ImmutablePolygon(vertices);
		}

	}
}
