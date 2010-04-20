package as3geometry.geom2D.mutable 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Angle;
	import as3geometry.geom2D.angle.MutableAngleFromVectors;
	import as3geometry.geom2D.vectors.ImmutableSpatialVector;

	import asunit.asserts.assertEquals;

	public class MutableAnglesFromVectorsTest 
	{
		private var context:AS3GeometryContext;
		
		private var a:ImmutableSpatialVector;		private var b:ImmutableSpatialVector;
		
		private var angle:Angle;
		
		[Before]
		public function before():void
		{
			context = new AS3GeometryContext();
		}
		
		[After]
		public function tearDown():void
		{
			context = null;
			a = null;
			b = null;
			angle = null;
		}
		
		[Test]
		public function test90Degrees():void
		{
			a = new ImmutableSpatialVector(10, 0);
			b = new ImmutableSpatialVector(0, 10);
			angle = new MutableAngleFromVectors(context, a, b);
			
			assertEquals(90, angle.degrees);
		}
		
		[Test]
		public function test90DegreesNegative():void
		{
			a = new ImmutableSpatialVector(10, 0);
			b = new ImmutableSpatialVector(0, 10);
			angle = new MutableAngleFromVectors(context, b, a);
			
			assertEquals(-90, angle.degrees);
		}
		
		[Test]
		public function testAngleAcrossZeroLine():void
		{
			a = new ImmutableSpatialVector(5,-5);
			b = new ImmutableSpatialVector(5,5);
			angle = new MutableAngleFromVectors(context, a, b);
			
			assertEquals(90, angle.degrees);
		}
		
		[Test]
		public function testNegativeAngleAcrossZeroLine():void
		{
			a = new ImmutableSpatialVector(5,-5);
			b = new ImmutableSpatialVector(5,5);
			angle = new MutableAngleFromVectors(context, b, a);
			
			assertEquals(-90, angle.degrees);
		}
		
		[Test]
		public function testRoundtrip():void
		{
			var ang:Number = Math.PI / 3;
			
			var cos:Number = Math.cos(ang);
			var sin:Number = Math.sin(ang);
			a = new ImmutableSpatialVector(5 * cos, 5 * sin);
			
			cos = Math.cos(2 * ang);
			sin = Math.sin(2 * ang);
			b = new ImmutableSpatialVector(3 * cos, 3 * sin);
			
			angle = new MutableAngleFromVectors(context, a, b);
			assertEquals(ang, angle.radians);
		}
		
	}
	
}
