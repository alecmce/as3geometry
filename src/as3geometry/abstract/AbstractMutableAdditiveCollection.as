package as3geometry.abstract
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.AdditiveCollection;

	import org.osflash.signals.Signal;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class AbstractMutableAdditiveCollection extends Mutable implements AdditiveCollection
	{

		private var _added:Signal;

		private var _removed:Signal;

		public function AbstractMutableAdditiveCollection(context:AS3GeometryContext, collectionClass:Class)
		{
			super(context);
			_added = new Signal(collectionClass);			_removed = new Signal(collectionClass);
		}

		public function get added():Signal
		{
			return _added;
		}

		public function get removed():Signal
		{
			return _removed;
		}
	}
}
