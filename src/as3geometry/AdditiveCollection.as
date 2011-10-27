package as3geometry
{
	import org.osflash.signals.Signal;

	/**
	 * Defines the common functionality which all collections must have. If
	 * generics were possible it would also have a getElement.<T> method but
	 * this is not yet available
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface AdditiveCollection
	{

		function get added():Signal;

		function get removed():Signal;

	}
}
