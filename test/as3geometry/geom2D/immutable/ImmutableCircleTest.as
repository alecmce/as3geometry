package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.circle.ImmutableCircle;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.vertices.MutableVertex;

	import asunit.asserts.fail;

	public class ImmutableCircleTest 
	{
		private var circle:ImmutableCircle;
		
		[After]
		public function tearDown():void
		{
			circle = null;
		}
		
		[Test]
		public function mutableErrorIsThrown():void
		{
			var a:MutableVertex = new MutableVertex(1,1);
			
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
