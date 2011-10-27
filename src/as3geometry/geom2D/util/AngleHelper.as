package as3geometry.geom2D.util
{
	import as3geometry.geom2D.Vertex;

	/**
	 * Contains functions to calculate angles in various forms
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class AngleHelper
	{

		private const TO_RADIANS:Number = Math.PI / 180;
		private const TO_DEGREES:Number = 180 / Math.PI;

		/**
		 * find the (directed) angle between the vector [aI,aJ] and [bI,bJ]
		 */
		public function directedAngleFromVectors(aI:Number, aJ:Number, bI:Number, bJ:Number):Number
		{
			var angA:Number = -Math.atan2(aJ, aI);
			var cosA:Number = Math.cos(angA);
			var sinA:Number = Math.sin(angA);

			var i:Number = bI * cosA - bJ * sinA;
			var j:Number = bI * sinA + bJ * cosA;

			return Math.atan2(j, i);
		}

		public function directedAngleFromVertices(center:Vertex, a:Vertex, b:Vertex):Number
		{
			var aI:Number = a.x - center.x;			var aJ:Number = a.y - center.y;			var bI:Number = b.x - center.x;			var bJ:Number = b.y - center.y;

			return directedAngleFromVectors(aI, aJ, bI, bJ);
		}

		public function toDegrees(radians:Number):Number
		{
			return radians * TO_DEGREES;
		}

		public function toRadians(degrees:Number):Number
		{
			return degrees * TO_RADIANS;
		}

	}
}
