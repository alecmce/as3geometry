package asunit.framework {
	import flash.errors.IllegalOperationError;	
	
	import asunit.errors.AssertionFailedError;	
	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	

	public class AsyncOperation{

		private var timeout:Timer;
		private var testCase:TestCase;
		private var callback:Function;
		private var duration:Number;

		public function AsyncOperation(testCase:TestCase, handler:Function, duration:Number){
			this.testCase = testCase;
			this.duration = duration;
			timeout = new Timer(duration, 1);
			timeout.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeoutComplete);
			timeout.start();
			if(handler == null) {
				handler = function(args:*):* {return;};
			}
			var context:AsyncOperation = this;
			callback = function(args:*):* {
				timeout.stop();
				try {
					handler.apply(testCase, arguments);
				}
				catch(e:AssertionFailedError) {
					testCase.getResult().addFailure(testCase, e);
				}
				catch(ioe:IllegalOperationError) {
					testCase.getResult().addError(testCase, ioe);
				}
				finally {
					testCase.asyncOperationComplete(context);
				}
				return;
			};
		}
		
		public function getCallback():Function{
			return callback;
		}

		private function onTimeoutComplete(event:TimerEvent):void {
			testCase.asyncOperationTimeout(this, duration);
		}
	}
	
}
