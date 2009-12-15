package as3geometry.abstract 
{
	import as3geometry.Mutable;

	import org.osflash.signals.Signal;

	/**
	 * A generic form for mutable objects which handles the adding and
	 * removing of definiens
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class AbstractMutable implements Mutable
	{
		protected var _changed:Signal;
		
		public function AbstractMutable()
		{
			_changed = new Signal(Mutable);
		}
		
		protected function addDefinien(definien:*):void
		{
			if (definien && definien is Mutable)
				definien.changed.add(onDefinienChanged);
		}
		
		protected function removeDefinien(definien:*):void
		{
			if (definien && definien is Mutable)
				definien.changed.remove(onDefinienChanged);
		}
		
		protected function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}

		public function get changed():Signal
		{
			return _changed;
		}
		
	}
}
