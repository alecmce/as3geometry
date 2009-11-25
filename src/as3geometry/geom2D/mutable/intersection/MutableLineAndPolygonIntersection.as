package as3geometry.geom2D.mutable.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.mutable.MutableLine;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableLineAndPolygonIntersection implements Mutable
	{

		private var _polygon:Polygon;
		
		private var _line:Line;
		
		private var _persistent:Vector.<Vertex>;
		
		private var _vertices:Vector.<Vertex>;
		
		private var _changed:ISignal;
		
		public function MutableLineAndPolygonIntersection(polygon:Polygon, line:Line)
		{
			_polygon = polygon;
			_line = line;
			_changed = new Signal(this, Mutable);
			
			if (_polygon is Mutable)
				Mutable(_polygon).changed.add(onDefiniensChanged);			
			if (_line is Mutable)
				Mutable(_line).changed.add(onDefiniensChanged);

			_persistent = calculateVertices();
		}
		
		private function onDefiniensChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}

		public function get vertices():Vector.<Vertex>
		{
			return _vertices;
		}
		
		private function calculateVertices():Vector.<Vertex>
		{
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			var count:int = 0;
			
			var len:int = _polygon.count;
			var b:Vertex = _polygon.get(len - 1);
			for (var i:int = 0; i < len; i++)
			{
				var a:Vertex = _polygon.get(i);
				var edge:MutableLine = new MutableLine(a, b, LineType.SEGMENT);
				var vertex:Vertex = new MutableTwoLinesIntersectionVertex(edge, _line);
				b = a;
				
				if (isNaN(vertex.x) || isNaN(vertex.y))
					continue;
					
				vertices[count++] = vertex;
			}
			
			return vertices;
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
