package as3geometry.geom2D.intersection 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.line.ImmutableLine;
	import as3geometry.geom2D.line.IntersectionOfTwoLinesVertex;
	import as3geometry.geom2D.vertices.ImmutableVertex;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertTrue;

	import flash.display.Sprite;

	public class IntersectionOfTwoLinesVertexTest
	{
		[Inject]
		private var root:Sprite;
		
		private var context:AS3GeometryContext;
		
		private var a:Line;
		private var b:Line;
		private var vertex:IntersectionOfTwoLinesVertex;

		[Before]
		public function before():void
		{
			context = new AS3GeometryContext(root);
		}

		[After]
		public function tearDown():void
		{
			context = null;
			
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
			vertex = new IntersectionOfTwoLinesVertex(context, a, b);
			assertEquals(x, vertex.x);			assertEquals(y, vertex.y);
		}
		
		private function resolveNoIntersection():void
		{
			vertex = new IntersectionOfTwoLinesVertex(context, a, b);
			assertTrue(isNaN(vertex.x));
			assertTrue(isNaN(vertex.y));
		}
		
	}
}
