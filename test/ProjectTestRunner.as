package
{
	import asunit.core.TextCore;

	import flash.display.Sprite;

	public class ProjectTestRunner extends Sprite
	{

		public function ProjectTestRunner()
		{
			var core:TextCore = new TextCore();
			core.start(AllTests, null, this);
		}

	}
}
