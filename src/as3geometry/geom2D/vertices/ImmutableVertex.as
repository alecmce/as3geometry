package as3geometry.geom2D.vertices
{
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a vertex on a cartesian plane
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableVertex implements Vertex
	{

		private var _x:Number;

		private var _y:Number;


		public function ImmutableVertex(x:Number, y:Number)
		{
			_x = x;
			_y = y;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}


	}
}
