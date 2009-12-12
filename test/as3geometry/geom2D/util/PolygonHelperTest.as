package as3geometry.geom2D.util 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.polygons.ImmutablePolygon;
	import as3geometry.geom2D.vertices.ImmutableVertex;

	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonHelperTest 
	{
		private var helper:PolygonHelper;
		
		[Before]
		public function setUp():void
		{
			helper = new PolygonHelper();
		}
		
		[After]
		public function tearDown():void
		{
			helper = null;
		}
		
		[Test]
		public function polygonIsAnticlockwise():void
		{
			var vertices:Array = [];			vertices[0] = new ImmutableVertex(0, 0);			vertices[1] = new ImmutableVertex(10, 0);			vertices[2] = new ImmutableVertex(10, 10);
			vertices[3] = new ImmutableVertex(0, 10);
			
			var polygon:Polygon = new ImmutablePolygon(vertices);
			
			assertFalse(helper.isPolygonClockwise(polygon));
		}
		
		[Test]
		public function polygonIsClockwise():void
		{
			var vertices:Array = [];
			vertices[0] = new ImmutableVertex(0, 0);
			vertices[1] = new ImmutableVertex(0, 10);
			vertices[2] = new ImmutableVertex(10, 10);
			vertices[3] = new ImmutableVertex(10, 0);
			
			var polygon:Polygon = new ImmutablePolygon(vertices);
			
			assertTrue(helper.isPolygonClockwise(polygon));
		}
		
	}
}
