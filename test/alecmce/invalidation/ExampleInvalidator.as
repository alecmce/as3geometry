package alecmce.invalidation 
{
	import alecmce.invalidation.signals.ChangedSignal;

	public class ExampleInvalidator implements Invalidates
	{
		private var _id:String;
		private var _isInvalid:Boolean;
		private var _changed:ChangedSignal;

		public function ExampleInvalidator(id:String) 
		{
			_id = id;
			_isInvalid = false;
			_changed = new ChangedSignal();
		}

		public function invalidate():void
		{
			if (_isInvalid)
				return;
			
			_isInvalid = true;
			_changed.dispatch(this);
		}

		public function get changed():ChangedSignal
		{
			return _changed;
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
