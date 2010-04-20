package alecmce.invalidation 
{
	import org.osflash.signals.Signal;

	public class InvalidationSignal extends Signal 
	{
		public function InvalidationSignal()
		{
			super(Invalidates);
		}
	}
}
