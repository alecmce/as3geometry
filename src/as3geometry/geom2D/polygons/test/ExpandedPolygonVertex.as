package as3geometry.geom2D.polygons.test 
{
	import as3geometry.geom2D.Vertex;

	/**
	 * This was intended to be an interface (see commit prior to this) but there is a
	 * problem with having a Array
	 * where the BranchInterface extends the RootInterface, so I resorted to this being
	 * an abstract base class
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class ExpandedPolygonVertex implements Vertex
	{
		public var visited:Boolean;
		
		public var isReal:Boolean;
		
		public var positionOnPolygonAAsCycle:Number;
		
		public var positionOnPolygonBAsCycle:Number;
		
		public var polygonIndex:int;

		public function ExpandedPolygonVertex()
		{
			polygonIndex = -1;
			visited = false;
		}
		
		public function get x():Number
		{
			return Number.NaN;
		}
		
		public function get y():Number
		{
			return Number.NaN;
		}
		
	}
}
