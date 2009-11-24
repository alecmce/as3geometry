package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.MutableVertex;

	import asunit.asserts.fail;

	public class ImmutableLineTest 
	{
		private var line:ImmutableLine;
		
		[After]
		public function tearDown():void
		{
			line = null;
		}
		
		[Test]
		public function mutableErrorIsThrown_parameterA():void
		{
			var a:MutableVertex = new MutableVertex(1,1);
			var b:ImmutableVertex = new ImmutableVertex(0,0);
			
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
			var a:ImmutableVertex = new ImmutableVertex(0,0);
			var b:MutableVertex = new MutableVertex(1,1);
			
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
