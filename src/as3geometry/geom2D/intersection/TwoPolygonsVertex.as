package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.intersection.IntersectionOfTwoLinesVertex;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class TwoPolygonsVertex extends IntersectionOfTwoLinesVertex 
	{
		private var _isIntersection:Boolean;
		
		private var _isIntersectionChanged:Boolean;
		
		public function TwoPolygonsVertex(a:Line, b:Line)
		{
			super(a, b);
			
			_isIntersection  = !isNaN(_x) && !isNaN(_y);
			_isIntersectionChanged = false;		}
		
		override protected function update():void
		{
			var newIsIntersection:Boolean = !isNaN(_x) && !isNaN(_y);
			_isIntersectionChanged = _isIntersection != newIsIntersection;
			_isIntersection = newIsIntersection;
		}
		
		public function get isIntersection():Boolean
		{
			if (_invalidated)
				update();
			
			return _isIntersection;
		}
		
		public function get isIntersectionChanged():Boolean
		{
			if (_invalidated)
				update();
			
			return _isIntersectionChanged;
		}
	}
}
