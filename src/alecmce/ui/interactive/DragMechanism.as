package alecmce.ui.interactive 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class DragMechanism 
	{
		private var _draggables:Array;
		
		private var _offsetX:Number;
		
		private var _offsetY:Number;
		
		private var _dragging:InteractiveObject;
		
		public function DragMechanism()
		{
			_draggables = [];
		}
		
		public function apply(target:InteractiveObject):void
		{
			if (_draggables.indexOf(target) != -1)
				return;
			
			_draggables.push(target);
			addEventListeners(target);
		}
		
		public function clear(target:InteractiveObject):void
		{
			var i:int = _draggables.indexOf(target);
			_draggables.splice(i, 1);
			
			removeEventListeners(target);
			
			if (_dragging == target)
				_dragging = null;
		}
		
		public function clearAll():void
		{
			var i:int = _draggables.length;
			while (--i > -1)
			{
				var target:InteractiveObject = _draggables[i];
				clear(target);
			}
		}

		private function addEventListeners(target:InteractiveObject):void
		{
			if (target.stage)
			{
				target.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
				target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			else
			{
				target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}		}
		
		private function removeEventListeners(target:InteractiveObject):void
		{
			target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			if (target.stage)
				target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onAddedToStage(event:Event):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);			
			target.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onRemovedFromStage(event:Event):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);
			
			target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onMouseDown(event:MouseEvent):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);
			
			_dragging = target;
			_dragging.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);			_dragging.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_offsetX = event.stageX - target.x;			_offsetY = event.stageY - target.y;
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_dragging.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);			_dragging.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_dragging = null;
		}

		private function onMouseMove(event:MouseEvent):void
		{
			_dragging.x = event.stageX + _offsetX;			_dragging.y = event.stageY + _offsetY;
			event.updateAfterEvent();
		}
	}
}
