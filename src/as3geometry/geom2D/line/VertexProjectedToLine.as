package as3geometry.geom2D.line 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;

	public class VertexProjectedToLine extends Mutable implements Vertex
	{
		private var _line:Line;
		private var _vertex:Vertex;
		
		private var _x:Number;
		private var _y:Number;

		public function VertexProjectedToLine(context:AS3GeometryContext, line:Line, vertex:Vertex) 
		{
			super(context);
			addDefinien(_vertex = vertex);
			addDefinien(_line = line);
			resolve();
		}

		public function get line():Line
		{
			return _line;
		}
		
		public function set line(value:Line):void
		{
			if (_line == value)
				return;
			
			removeDefinien(_line);
			_line = value;
			addDefinien(_line);
			invalidate();
		}
		
		public function get vertex():Vertex
		{
			return _vertex;
		}
		
		public function set vertex(value:Vertex):void
		{
			if (_vertex == value)
				return;
			
			removeDefinien(_vertex);
			_vertex = value;
			addDefinien(_vertex);
			invalidate();
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}

		override public function resolve():void 
		{
			super.resolve();
			
			var a:Vertex = _line.a;
			var v:SpatialVector = _line.vector;
			
			var x:Number = _vertex.x;
			var y:Number = _vertex.y;
			var i:Number = v.i;
			var j:Number = v.j;
			var n:Number = x - a.x;
			var m:Number = y - a.y;
			
			var delta:Number = (j * n - i * m) / (i * i + j * j);
			
			_x = x - j * delta;
			_y = y + i * delta;
		}
		
	}
}
