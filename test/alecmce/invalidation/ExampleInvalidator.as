package alecmce.invalidation 
{
	import org.osflash.signals.Signal;

	public class ExampleInvalidator implements Invalidates
	{
		private var _id:String;
		private var _isInvalid:Boolean;
		private var _changed:Signal;

		public function ExampleInvalidator(id:String) 
		{
			_id = id;
			_isInvalid = false;
			_changed = new Signal();
		}

		public function invalidate():void
		{
			if (_isInvalid)
				return;
			
			_isInvalid = true;
			_changed.dispatch(this);
		}

		public function get changed():Signal
		{
			return _changed;
		}
		
		public function get invalidated():Signal
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
