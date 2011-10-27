package alecmce.invalidation.signals
{
	import alecmce.invalidation.Invalidates;

	import org.osflash.signals.Signal;

	public class InvalidationSignal extends Signal
	{
		public function InvalidationSignal()
		{
			super(Invalidates);
		}
	}
}
