package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.intersection.IntersectionOfTwoLinesVertex;

	/**
	 * A vertex that lies on the intersection of two vertices
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class PolygonsIntersectionVertex extends IntersectionOfTwoLinesVertex implements IntersectionOfTwoPolygonsVertex 
	{
		private var _isReal:Boolean;
		
		private var _hasRealValueChanged:Boolean;
		
		private var _aIndex:uint;
		
		private var _bIndex:uint;
		
		private var _positionOnPolygonAAsCycle:Number;
		
		private var _positionOnPolygonBAsCycle:Number;
		
		private var _visited:Boolean;

		public function PolygonsIntersectionVertex(a:Line, b:Line, aIndex:uint, bIndex:uint)
		{
			super(a, b);
			_aIndex = aIndex;			_bIndex = bIndex;
			
			update();
			_hasRealValueChanged = false;
		}

		override protected function update():void
		{
			super.update();
			
			var newIsIntersection:Boolean = !isNaN(_x) && !isNaN(_y);
			_hasRealValueChanged = _isReal != newIsIntersection;
			_isReal = newIsIntersection;
			
			if (_isReal)
			{
				_positionOnPolygonAAsCycle = _aIndex + aMultiplier;
				_positionOnPolygonBAsCycle = _bIndex + bMultiplier;
			}
			else
			{
				_positionOnPolygonAAsCycle = Number.NaN;
				_positionOnPolygonBAsCycle = Number.NaN;
			}
		}
		
		public function get isReal():Boolean
		{
			if (_invalidated)
				update();
			
			return _isReal;
		}
		
		public function get hasRealValueChanged():Boolean
		{
			if (_invalidated)
				update();
			
			return _hasRealValueChanged;
		}
		
		public function resetChangedFlag():void
		{
			_hasRealValueChanged = false;
		}
		
		public function get positionOnPolygonAAsCycle():Number
		{
			if (_invalidated)
				update();
			
			return _positionOnPolygonAAsCycle;
		}
		
		public function get positionOnPolygonBAsCycle():Number
		{
			if (_invalidated)
				update();
			
			return _positionOnPolygonBAsCycle;
		}
		
		public function get visited():Boolean
		{
			return _visited;
		}
		
		public function set visited(value:Boolean):void
		{
			_visited = value;
		}
		
		public function toString() : String
		{
			var str:String = "Intersection: (@X@,@Y@)";
			str = str.replace("@X@", x);			str = str.replace("@Y@", y);
			
			return str;
		}
	}
}
