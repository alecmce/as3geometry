package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutableVertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Defines a circle on a Cartesian plane by center Vertex and radius
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircle implements Circle, Mutable
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** The center of the circle */
		private var _center:Vertex;
				
		/** The radius of the circle */
		private var _radius:Number;
		
		private var _changed:ISignal;

		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		/**
		 * Class Constructor
		 * 
		 * @param center The center of the circle
		 * @param radius The radius of the circle
		 */
		public function MutableCircle(center:Vertex = null, radius:Number = 1)
		{
			_center = center ? center : new ImmutableVertex(0, 0);
			_changed = new Signal(this, Mutable);
			
			if (_center is Mutable)
				Mutable(_center).changed.add(onDefinienChanged);
				
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
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
