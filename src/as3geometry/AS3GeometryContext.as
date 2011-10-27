package as3geometry
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.InvalidationManager;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class AS3GeometryContext
	{
		private var _root:DisplayObjectContainer;
		private var _invalidationManager:InvalidationManager;

		public function AS3GeometryContext(root:DisplayObjectContainer)
		{
			_root = root;
			_invalidationManager = new InvalidationManager();
			_invalidationManager.invalidated.add(onInvalidated);
		}

		public function register(invalidates:Invalidates):void
		{
			_invalidationManager.register(invalidates);
		}

		public function get invalidationManager():InvalidationManager
		{
			return _invalidationManager;
		}

		private function onInvalidated():void
		{
			if (_root.stage)
			{
				_root.stage.addEventListener(Event.RENDER, onStageRender);
				_root.stage.invalidate();
			}
			else
			{
				_root.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}

		private function onAddedToStage(event:Event):void
		{
			_root.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_invalidationManager.resolve();
		}

		private function onStageRender(event:Event):void
		{
			_root.removeEventListener(Event.RENDER, onStageRender);
			_invalidationManager.resolve();
		}
	}
}
