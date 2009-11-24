package as3geometry.geom2D.mutable 
{
	import org.osflash.signals.ISignal;

	/**
	 * An interface which all mutable elements should implement
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Mutable 
	{
		
		/**
		 * @return A signal that emits when a core property of the object is changed
		 */
		function get changed():ISignal;
			
	}
}
