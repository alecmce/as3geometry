package alecmce.invalidation 
{
	import alecmce.invalidation.signals.InvalidationSignal;

	public class ExampleInvalidator implements Invalidates
	{
		private var _id:String;
		private var _isInvalid:Boolean;
		private var _invalidated:InvalidationSignal;

		public function ExampleInvalidator(id:String) 
		{
			_id = id;
			_isInvalid = false;
			_invalidated = new InvalidationSignal();
		}

		public function invalidate(resolve:Boolean = false):void
		{
			if (_isInvalid)
				return;
			
			_isInvalid = true;
			_invalidated.dispatch(this);
		}

		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get isInvalid():Boolean
		{
			return _isInvalid;
		}
		
		public function resolve():void
		{
			_isInvalid = false;
		}
		
		public function toString():String
		{
			return _id;
		}
		
	}
}
