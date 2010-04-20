package as3geometry.geom2D.polygons.intersection 
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.InvalidationSignal;

	import as3geometry.geom2D.Vertex;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class OrignalPolygonVertexWrapper extends ExpandedPolygonVertex
	{
		private var _original:Vertex;

		private var _invalidated:InvalidationSignal;
		
		public function OrignalPolygonVertexWrapper(original:Vertex, aIndex:int, bIndex:int)
		{
			_original = original;
			if (_original is Invalidates)
				_invalidated = Invalidates(_original).invalidated;
			else
				_invalidated = new InvalidationSignal();
		
			positionOnPolygonAAsCycle = aIndex;
			positionOnPolygonBAsCycle = bIndex;
			isReal = true;
			visited = false;
		}

		override public function get x():Number
		{
			return _original.x;
		}

		override public function get y():Number
		{
			return _original.y;
		}

		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get target():Vertex
		{
			return _original;
		}
		
		public function toString() : String
		{
			var str:String = "Vertex: (@X@,@Y@)";
			str = str.replace("@X@", x);
			str = str.replace("@Y@", y);
			
			return str;
		}
		
	}
}
