package as3geometry.geom2D.ui.generic 
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.signals.InvalidationSignal;

	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.ui.DEFAULT_PAINT;

	import alecmce.ui.Paint;

	import flash.display.Sprite;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class UIMutableSprite extends Sprite implements Invalidates
	{
		private var _paint:Paint;
		protected var _redraw:Boolean;
		
		private var _isInvalid:Boolean;
		private var _invalidated:InvalidationSignal;
		private var _context:AS3GeometryContext;

		public function UIMutableSprite(context:AS3GeometryContext, paint:Paint) 
		{
			_context = context;
			_paint = paint;
			_redraw = true;
			_invalidated = new InvalidationSignal();
			_context.invalidationManager.register(this);
			_isInvalid = false;
		}

		public function get paint():Paint
		{
			return _paint ||= DEFAULT_PAINT;
		}

		public function set paint(paint:Paint):void
		{
			_paint = paint;
			_redraw = true;
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
		
		public function invalidate(resolveImmediately:Boolean = false):void
		{
			_isInvalid = true;
			_invalidated.dispatch(this, resolveImmediately);
		}

		public function resolve():void
		{
			_isInvalid = false;
			
			if (_redraw)
			{
				_redraw = false;
				redraw();
			}
		}
		
		protected function redraw():void
		{
			
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
