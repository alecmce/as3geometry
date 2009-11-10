package as3geometry.geom2D.minimal 
{
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a vertex on a cartesian plane
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MinimalVertex implements Vertex 
	{
		
		private var x_:Number;
		
		private var y_:Number;
		
		
		public function MinimalVertex(x:Number, y:Number)
		{
			x_ = x;
			y_ = y;
		}
		
		public function get x():Number
		{
			return x_;
		}
		
		public function get y():Number
		{
			return y_;
		}
		
		
	}
}
