package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutableLine;
	import as3geometry.geom2D.immutable.ImmutablePolygon;
	import as3geometry.geom2D.immutable.ImmutableVertex;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertTrue;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionsOfLineAndPolygonTest 
	{
		
		private var line:Line;
		private var polygon:Polygon;
		private var intersections:IntersectionsOfLineAndPolygon;
		
		[After]
		public function tearDown():void
		{
			line = null;
			polygon = null;
			intersections = null;
		}
		
		[Test]
		public function squareWithHorizontalLine():void
		{
			generateSquare();
			
			var a:Vertex = new ImmutableVertex(0, 5);			var b:Vertex = new ImmutableVertex(10, 5);
			line = new ImmutableLine(a, b);
			
			intersections = new IntersectionsOfLineAndPolygon(polygon, line);
			var vertices:Vector.<Vertex> = intersections.actualIntersections;
			
			a = vertices[0];
			b = vertices[1];
			
			assertEquals(2, a.x);			assertEquals(5, a.y);			assertEquals(8, b.x);			assertEquals(5, b.y);
		}
		
		
		[Test]
		public function squareWithVerticalLine():void
		{
			generateSquare();
			
			var a:Vertex = new ImmutableVertex(5, 0);
			var b:Vertex = new ImmutableVertex(5, 10);
			line = new ImmutableLine(a, b);
			
			intersections = new IntersectionsOfLineAndPolygon(polygon, line);
			var vertices:Vector.<Vertex> = intersections.actualIntersections;
			
			a = vertices[0];
			b = vertices[1];
			
			assertEquals(5, a.x);
			assertEquals(2, a.y);
			assertEquals(5, b.x);
			assertEquals(8, b.y);
		}
		
		
		[Test]
		public function squareWithSmallLine():void
		{
			generateSquare();
			
			var a:Vertex = new ImmutableVertex(0, 4);
			var b:Vertex = new ImmutableVertex(4, 4);
			line = new ImmutableLine(a, b, LineType.SEGMENT);
			
			intersections = new IntersectionsOfLineAndPolygon(polygon, line);
			var vertices:Vector.<Vertex> = intersections.actualIntersections;
			
			a = vertices[0];
			b = vertices[1];
			
			assertEquals(2, a.x);
			assertEquals(4, a.y);
			trace(b);
			assertTrue(isNaN(b.x));
			assertTrue(isNaN(b.y));
		}
		
		
		private function generateSquare():void
		{
			var vertices:Vector.<Vertex> = new Vector.<Vertex>(4, true);
			vertices[0] = new ImmutableVertex(2, 2);
			vertices[1] = new ImmutableVertex(8, 2);
			vertices[2] = new ImmutableVertex(8, 8);
			vertices[3] = new ImmutableVertex(2, 8);
			
			polygon = new ImmutablePolygon(vertices);
		}
		
	}
}
