package as3geometry.geom2D.ui.generic 
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.InvalidationSignal;

	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.ui.DEFAULT_PAINT;

	import ui.Paint;

	import flash.display.Sprite;

	/**
	 * @author amceachran
	 */
	public class UIMutableSprite extends Sprite implements Invalidates
	{
		private var _paint:Paint;
		
		private var _isInvalid:Boolean;
		private var _invalidated:InvalidationSignal;
		private var _context:AS3GeometryContext;

		public function UIMutableSprite(context:AS3GeometryContext, paint:Paint) 
		{
			_paint = paint;
			_context = context;
			_invalidated = new InvalidationSignal();
			_isInvalid = false;
		}
		
		public function get paint():Paint
		{
			return _paint ||= DEFAULT_PAINT;
		}

		public function set paint(paint:Paint):void
		{
			if (_paint == paint)
				return;
			
			_paint = paint;
			invalidate();
		}
		
		public function get context():AS3GeometryContext
		{
			return _context;
		}
		
		protected function addDefinien(definien:*):void
		{
			var abstract:Mutable = definien;
			if (abstract)
				_context.invalidationManager.addDependency(abstract, this);
		}

		protected function removeDefinien(definien:*):void
		{
			var abstract:Mutable = definien;
			if (abstract)
				_context.invalidationManager.removeDependency(abstract, this);
		}
		
		public function invalidate():void
		{
			_isInvalid = true;
			_invalidated.dispatch(this);
		}
		
		public function resolve():void
		{
			_isInvalid = false;
		}
		
		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get isInvalid():Boolean
		{
			return false;
		}
		
	}
}
