package as3geometry.abstract 
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.InvalidationSignal;

	import as3geometry.AS3GeometryContext;

	/**
	 * A generic form for mutable objects which handles the adding and
	 * removing of definiens
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class Mutable implements Invalidates
	{
		private var _context:AS3GeometryContext;
		
		private var _invalidated:InvalidationSignal;
		
		private var _isInvalidated:Boolean;

		public function Mutable(context:AS3GeometryContext)
		{
			_context = context;
			_invalidated = new InvalidationSignal();
			_isInvalidated = false;
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
			_isInvalidated = true;
		}
		
		public function resolve():void
		{
			_isInvalidated = false;
		}
		
		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get isInvalid():Boolean
		{
			return _isInvalidated;
		}
		
		public function get context():AS3GeometryContext
		{
			return _context;
		}
	}
}
