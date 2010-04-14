package alecmce.invalidation.signals 
{
	import alecmce.invalidation.Invalidates;

	import org.osflash.signals.Signal;

	public class ChangedSignal extends Signal 
	{
		public function ChangedSignal()
		{
			super(Invalidates);
		}
	}
}
