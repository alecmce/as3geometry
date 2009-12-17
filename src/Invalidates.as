package  
{

	/**
	 * An invalidating object is invalidated when a property is changed (or if it has a
	 * Mutable definien, when that definien changes), but does not immediately update itself.
	 * Invalidated elements are updated by calling the update() method, after which isInvalidated
	 * should be false.
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Invalidates extends Mutable
	{
		
		function get isInvalidated():Boolean;
		
		function update():void;
		
	}
}
