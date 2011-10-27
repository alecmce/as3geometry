package as3geometry.geom2D
{

	/**
	 * An enumeration of line types:
	 *
	 * A LINE extends infinitely in both directions from the two definitional vertices
	 *
	 * A RAY starts at Vertex a and extends infinitely through Vertex b
	 *
	 * A SEGMENT starts at Vertex a and stops at Vertex b
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class LineType
	{

		public static const LINE:LineType = new LineType(checkLine);

		private static function checkLine(n:Number):Boolean
		{
			n; // stop FDT warning
			return true;
		}

		public static const RAY:LineType = new LineType(checkRay);

		private static function checkRay(n:Number):Boolean
		{
			return n >= 0;
		}

		public static const SEGMENT:LineType = new LineType(checkSegment);

		private static function checkSegment(n:Number):Boolean
		{
			return n >= 0 && n <= 1;
		}

		private var fn:Function;

		public function LineType(fn:Function)
		{
			this.fn = fn;
		}

		public function isValidPositionMultiplier(n:Number):Boolean
		{
			if (isNaN(n))
				return false;

			return fn(n);
		}


	}
}
