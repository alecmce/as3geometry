package as3geometry.geom2D.polygons.intersection 
{
	import as3geometry.Mutable;
	import as3geometry.geom2D.Vertex;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class OrignalPolygonVertexWrapper extends ExpandedPolygonVertex implements Mutable
	{
		private var _original:Vertex;

		private var _changed:ISignal;
		
		public function OrignalPolygonVertexWrapper(target:Vertex, aIndex:int, bIndex:int)
		{
			_original = target;
			_changed = _original is Mutable ? Mutable(_original).changed : new Signal(this);
		
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

		public function get changed():ISignal
		{
			return _changed;
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
