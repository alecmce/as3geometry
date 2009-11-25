package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.immutable.ImmutableVertex;
	import as3geometry.geom2D.immutable.ImmutableLine;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertTrue;

	public class IntersectionOfTwoLinesVertexTest
	{
		private var a:Line;
		private var b:Line;
		private var vertex:IntersectionOfTwoLinesVertex;

		[After]
		public function tearDown():void
		{
			a = null;			b = null;			vertex = null;
		}
		
		[Test]
		public function verticalAndHorizontal():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,5), new ImmutableVertex(10,5));
			b = new ImmutableLine(new ImmutableVertex(5,0), new ImmutableVertex(5,10));
			resolve(5,5);
		}
		
		[Test]
		public function verticalAndHorizontal_WithHorizonalOffset():void
		{
			a = new ImmutableLine(new ImmutableVertex(3,5), new ImmutableVertex(13,5));
			b = new ImmutableLine(new ImmutableVertex(5,0), new ImmutableVertex(5,10));
			resolve(5,5);
		}
		
		[Test]
		public function verticalAndHorizontal_WithVerticalOffset():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,5), new ImmutableVertex(10,5));
			b = new ImmutableLine(new ImmutableVertex(5,3), new ImmutableVertex(5,13));
			resolve(5,5);
		}
		
		[Test]
		public function diagonals():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,0), new ImmutableVertex(10,10));			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(0,10));
			resolve(5,5);
		}
		
		[Test]
		public function diagonals_WithOffset():void
		{
			a = new ImmutableLine(new ImmutableVertex(3,3), new ImmutableVertex(10,10));
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(0,10));
			resolve(5,5);
		}
		
		[Test]
		public function parallel():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,0), new ImmutableVertex(0,10));
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(10,10));
			resolveNoIntersection();
		}
		
		[Test]
		public function sectionsDontIntersect():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,5), new ImmutableVertex(5,5), LineType.SEGMENT);
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(10,10), LineType.SEGMENT);
			resolveNoIntersection();
		}
		
		[Test]
		public function sectionsDontIntersect_JustOneIsSegment():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,5), new ImmutableVertex(5,5), LineType.SEGMENT);
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(10,10));
			resolveNoIntersection();
		}
		
		[Test]
		public function raysDontIntersect():void
		{
			a = new ImmutableLine(new ImmutableVertex(5,5), new ImmutableVertex(0,5), LineType.RAY);
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(10,10));
			resolveNoIntersection();
		}
		
		[Test]
		public function raysDoIntersect_CounterpartToTestRaysDontIntersect():void
		{
			a = new ImmutableLine(new ImmutableVertex(0,5), new ImmutableVertex(5,5), LineType.RAY);
			b = new ImmutableLine(new ImmutableVertex(10,0), new ImmutableVertex(10,10));
			resolve(10, 5);
		}
		
		// Private Methods for performing equality tests (since they're always the same form!
		
		private function resolve(x:Number, y:Number):void
		{
			vertex = new IntersectionOfTwoLinesVertex(a, b);
			assertEquals(x, vertex.x);			assertEquals(y, vertex.y);
		}
		
		private function resolveNoIntersection():void
		{
			vertex = new IntersectionOfTwoLinesVertex(a, b);
			assertTrue(isNaN(vertex.x));
			assertTrue(isNaN(vertex.y));
		}
		
	}
}
