package as3geometry.errors
{

	/**
	 * An error that is thrown if an immutable object defined by a mutable object
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutabilityError extends Error
	{
		public function MutabilityError(message:String)
		{
			super(message);
		}
	}
}
