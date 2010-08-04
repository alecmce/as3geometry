package as3geometry.geom2D.immutable 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.line.ImmutableLine;
	import as3geometry.geom2D.vertices.ImmutableVertex;
	import as3geometry.geom2D.vertices.MutableVertex;

	import asunit.asserts.fail;

	import flash.display.Sprite;

	public class ImmutableLineTest 
	{
		[Inject]
		public var sprite:Sprite;
		
		private var line:ImmutableLine;
		private var context:AS3GeometryContext;


		[Before]
		public function setup():void
		{
			context = new AS3GeometryContext(sprite);
		}

		[After]
		public function tearDown():void
		{
			line = null;
		}

		[Test]
		public function mutableErrorIsThrown_parameterA():void
		{
			var a:MutableVertex = new MutableVertex(context, 1, 1);
			var b:ImmutableVertex = new ImmutableVertex(0, 0);
			
			try
			{
				line = new ImmutableLine(a, b);
			}
			catch (error:MutabilityError)
			{
				return;
			}
			
			fail("ImmutableLine should throw a mutability error if a mutable vertex is used as a defining point");
		}

		[Test]
		public function mutableErrorIsThrown_parameterB():void
		{
			var a:ImmutableVertex = new ImmutableVertex(0, 0);
			var b:MutableVertex = new MutableVertex(context, 1, 1);
			
			try
			{
				line = new ImmutableLine(a, b);
			}
			catch (error:MutabilityError)
			{
				return;
			}
			
			fail("ImmutableLine should throw a mutability error if a mutable vertex is used as a defining point");
		}
	}
}
