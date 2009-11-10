package as3geometry.geom2D.minimal 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MinimalCircle implements Circle
	{
		
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** The center of the circle */
		private var center_:Vertex;
				
		/** The radius of the circle */
		private var radius_:Number;
		
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		/**
		 * Class Constructor
		 * 
		 * @param center The center of the circle
		 * @param radius The radius of the circle
		 */
		public function MinimalCircle(center:Vertex = null, radius:Number = 1)
		{
			center_ = center ? center : new MinimalVertex(0, 0);
			radius_ = radius;
		}
		
		
		/**
		 * @return The center of the circle
		 */
		public function get center():Vertex
		{
			return center_;
		}
		
		
		/**
		 * @return The radius of the circle
		 */
		public function get radius():Number
		{
			return radius_;
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
