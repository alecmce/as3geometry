package as3geometry 
{
	import asunit4.ui.MinimalRunnerUI;

	public class AS3GeometryTestRunner extends MinimalRunnerUI
	{
		public function AS3GeometryTestRunner()
		{
			run(as3geometry.AllTests);
		}
	}
}
