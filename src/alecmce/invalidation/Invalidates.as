package alecmce.invalidation 
{
	import alecmce.invalidation.signals.InvalidationSignal;

	public interface Invalidates 
	{
		function invalidate(resolveImmediately:Boolean = false):void;
		
		function get invalidated():InvalidationSignal;
		
		function get isInvalid():Boolean;

		function resolve():void;
	}
}
