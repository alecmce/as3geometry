package alecmce.invalidation 
{
	import org.osflash.signals.Signal;

	public interface Invalidates
	{
		function invalidate():void;
		
		function get invalidated():Signal;
		
		function get isInvalid():Boolean;

		function resolve():void;
	}
}
