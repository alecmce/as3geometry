package as3geometry.geom2D.immutable
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.circle.ImmutableCircle;
	import as3geometry.geom2D.vertices.IndependentVertex;

	import asunit.asserts.fail;

	import flash.display.Sprite;

	public class ImmutableCircleTest
	{
		private var circle:ImmutableCircle;
		private var context:AS3GeometryContext;

		[Inject]
		public var sprite:Sprite;

		[Before]
		public function setup():void
		{
			context = new AS3GeometryContext(sprite);
		}

		[After]
		public function tearDown():void
		{
			circle = null;
		}

		[Test]
		public function mutableErrorIsThrown():void
		{
			var a:IndependentVertex = new IndependentVertex(context, 1, 1);

			try
			{
				circle = new ImmutableCircle(a, 2);
			}
			catch (error:MutabilityError)
			{
				return;
			}

			fail("ImmutableCircle should throw a mutability error if a mutable vertex is used as its centre");
		}

	}
}
