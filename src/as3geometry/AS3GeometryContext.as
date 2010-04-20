package as3geometry 
{
	import alecmce.invalidation.InvalidationManager;

	public class AS3GeometryContext 
	{
		private var _invalidationManager:InvalidationManager;

		public function AS3GeometryContext() 
		{
			_invalidationManager = new InvalidationManager();
		}
		
		public function get invalidationManager():InvalidationManager
		{
			return _invalidationManager;
		}
	}
}
