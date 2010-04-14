package alecmce.invalidation 
{

	public interface Invalidates extends Mutable
	{
		function invalidate():void;
				
		function get isInvalid():Boolean;

		function resolve():void;
	}
}
