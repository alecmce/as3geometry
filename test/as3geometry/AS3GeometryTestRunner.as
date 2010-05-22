package as3geometry 
{
	import asunit.runners.TestRunner;

	public class AS3GeometryTestRunner extends TestRunner
	{
		public function AS3GeometryTestRunner()
		{
			run(as3geometry.AllGeometryTests);
		}
	}
}
