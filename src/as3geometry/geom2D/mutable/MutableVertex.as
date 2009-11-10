package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Vertex;

	import flash.events.EventDispatcher;

	/**
	 * Defines a vertex on a cartesian plane the position of whcih can be changed
	 * by setting its x and y values
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableVertex extends EventDispatcher implements Vertex 
	{
		
		private var x_:Number;
		
		private var y_:Number;
		
		
		public function MutableVertex(x:Number, y:Number)
		{
			x_ = x;
			y_ = y;
		}
		
		
		public function set x(value:Number):void
		{
			x_ = value;
		}
		
		
		public function get x():Number
		{
			return x_;
		}
		
		
		public function set y(value:Number):void
		{
			y_ = value;
		}
		
		
		public function get y():Number
		{
			return y_;
		}
		
	}
}
