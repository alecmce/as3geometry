package as3geometry.geom2D.mutable.abstract 
{
	import as3geometry.geom2D.collections.AdditiveCollection;
	import as3geometry.geom2D.mutable.abstract.AbstractMutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class AbstractMutableAdditiveCollection extends AbstractMutable implements AdditiveCollection
	{
		
		private var _added:ISignal;
		
		private var _removed:ISignal;
		
		public function AbstractMutableAdditiveCollection(collectionClass:Class)
		{
			_added = new Signal(this, collectionClass);			_removed = new Signal(this, collectionClass);
		}
		
		public function get added():ISignal
		{
			return _added;
		}
		
		public function get removed():ISignal
		{
			return _removed;
		}
	}
}
