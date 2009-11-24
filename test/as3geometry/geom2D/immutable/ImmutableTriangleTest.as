package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.MutableVertex;

	import asunit.asserts.fail;

	public class ImmutableTriangleTest 
	{
		private var triangle:ImmutableTriangle;
		
		[After]
		public function tearDown():void
		{
			triangle = null;
		}
		
		[Test]
		public function mutableErrorIsThrown_parameterA():void
		{
			var a:MutableVertex = new MutableVertex(1,1);
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
			var b:MutableVertex = new MutableVertex(1,1);
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
			var c:MutableVertex = new MutableVertex(1,1);
			
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
