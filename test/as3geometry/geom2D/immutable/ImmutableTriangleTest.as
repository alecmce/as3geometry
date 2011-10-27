package as3geometry.geom2D.immutable
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.polygons.ImmutableTriangle;
	import as3geometry.geom2D.vertices.ImmutableVertex;
	import as3geometry.geom2D.vertices.IndependentVertex;

	import asunit.asserts.fail;

	import flash.display.Sprite;

	public class ImmutableTriangleTest
	{
		[Inject]
		public var sprite:Sprite;

		private var triangle:ImmutableTriangle;
		private var context:AS3GeometryContext;

		[Before]
		public function setup():void
		{
			context = new AS3GeometryContext(sprite);
		}

		[After]
		public function tearDown():void
		{
			triangle = null;
		}

		[Test]
		public function mutableErrorIsThrown_parameterA():void
		{
			var a:IndependentVertex = new IndependentVertex(context, 1,1);
			var b:ImmutableVertex = new ImmutableVertex(0,0);			var c:ImmutableVertex = new ImmutableVertex(2,0);
			try
			{
				triangle = new ImmutableTriangle(a, b, c);
			}
			catch (error:MutabilityError)
			{
				return;
			}

			fail("ImmutableTriangle should throw a mutability error if a mutable vertex is used as a defining point");
		}

		[Test]
		public function mutableErrorIsThrown_parameterB():void
		{
			var a:ImmutableVertex = new ImmutableVertex(0,5);
			var b:IndependentVertex = new IndependentVertex(context,1,1);
			var c:ImmutableVertex = new ImmutableVertex(0,0);

			try
			{
				triangle = new ImmutableTriangle(a, b, c);
			}
			catch (error:MutabilityError)
			{
				return;
			}

			fail("ImmutableTriangle should throw a mutability error if a mutable vertex is used as a defining point");
		}

		[Test]
		public function mutableErrorIsThrown_parameterC():void
		{
			var a:ImmutableVertex = new ImmutableVertex(0,5);
			var b:ImmutableVertex = new ImmutableVertex(0,0);
			var c:IndependentVertex = new IndependentVertex(context,1,1);

			try
			{
				triangle = new ImmutableTriangle(a, b, c);
			}
			catch (error:MutabilityError)
			{
				return;
			}

			fail("ImmutableTriangle should throw a mutability error if a mutable vertex is used as a defining point");
		}
	}
}
