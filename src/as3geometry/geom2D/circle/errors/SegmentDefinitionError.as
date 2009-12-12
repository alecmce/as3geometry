package as3geometry.geom2D.circle.errors 
{
	import Error;

	/**
	 * An error that is thrown if a segment is defined incorrectly
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class SegmentDefinitionError extends Error 
	{
		public function SegmentDefinitionError(message:String)
		{
			super(message);
		}
	}
}
