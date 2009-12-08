package as3geometry.geom2D.intersection.twopolygons 
{
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class PolygonVertexWrapper implements Mutable, Vertex, IntersectionOfTwoPolygonsVertex
	{
		private var _changed:ISignal;
		
		private var _target:Vertex;
		
		private var _aIndex:int;
		private var _bIndex:int;
		
		private var _visited:Boolean;

		public function PolygonVertexWrapper(target:Vertex, aIndex:int, bIndex:int)
		{
			_target = target;
			_changed = _target is Mutable ? Mutable(_target).changed : new Signal(this);
		
			_aIndex = aIndex;
			_bIndex = bIndex;
		}
		
		public function get x():Number
		{
			return _target.x;
		}
		
		public function get y():Number
		{
			return _target.y;
		}
		
		public function get positionOnPolygonAAsCycle():Number
		{
			return _aIndex;
		}
		
		public function get positionOnPolygonBAsCycle():Number
		{
			return _bIndex;
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
		
		public function get visited():Boolean
		{
			return _visited;
		}
		
		public function set visited(value:Boolean):void
		{
			_visited = value;
		}
		
		public function get isReal():Boolean
		{
			return true;
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
