package as3geometry.geom2D.circle
{
	import as3geometry.abstract.Mutable;
	import as3geometry.errors.MutabilityError;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.vertices.ImmutableVertex;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableCircle implements Circle
	{

		/*********************************************************************/
		// Member Variables
		/*********************************************************************/


		/** The center of the circle */
		private var _center:Vertex;

		/** The radius of the circle */
		private var _radius:Number;


		/*********************************************************************/
		// Public Methods
		/*********************************************************************/


		/**
		 * Class Constructor
		 *
		 * @param center The center of the circle
		 * @param radius The radius of the circle
		 */
		public function ImmutableCircle(center:Vertex = null, radius:Number = 1)
		{
			_center = center ? center : new ImmutableVertex(0, 0);

			if (_center is Mutable)
				throw new MutabilityError("The ImmutableCircle's definitional center is mutable");

			_radius = radius;
		}


		/**
		 * @return The center of the circle
		 */
		public function get center():Vertex
		{
			return _center;
		}

		/**
		 * @return The radius of the circle
		 */
		public function get radius():Number
		{
			return _radius;
		}

		/**
		 * @return A user-readable string describing this circle
		 */
		public function toString():String
		{
			return "[CIRCLE " + center + ", r=" + radius + "]";
		}

	}
}
