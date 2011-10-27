package examples
{
	import as3geometry.AS3GeometryContext;

	import flash.display.Sprite;

	public class ExampleBaseSprite extends Sprite
	{
		protected var _context:AS3GeometryContext;

		public function ExampleBaseSprite()
		{
			_context = new AS3GeometryContext(this);
			init();
		}

		public function get context():AS3GeometryContext
		{
			return _context;
		}

		protected function init():void
		{
			// to be overridden
		}

	}
}
