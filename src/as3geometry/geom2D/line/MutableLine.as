package as3geometry.geom2D.line 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a line on a Cartesian plane by two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableLine extends Mutable implements Line, SpatialVector, Mutable
	{
		
		private var _a:Vertex;
		
		private var _b:Vertex;
		
		private var _type:LineType;
		
		public function MutableLine(context:AS3GeometryContext, a:Vertex, b:Vertex, type:LineType = null)
		{
			super(context);
			addDefinien(_a = a);
			addDefinien(_b = b);
			_type = type ? type : LineType.LINE;
		}
		
		public function get a():Vertex
		{
			return _a;
		}
		
		public function set a(a:Vertex):void
		{
			if (_a == a)
				return;
			
			removeDefinien(_a);
			_a = a;
			addDefinien(_a);
			invalidate();
		}
		
		public function get b():Vertex
		{
			return _b;
		}
		
		public function set b(b:Vertex):void
		{
			if (_b == b)
				return;
			
			removeDefinien(_b);
			_b = b;
			addDefinien(_b);
			invalidate();
		}
	
		public function get i():Number
		{
			return _b.x - _a.x;
		}
		
		public function get j():Number
		{
			return _b.y - _a.y;
		}
		
		public function get length():Number
		{
			var I:Number = i;			var J:Number = j;
			return Math.sqrt(I * I + J * J);
		}
		
		public function get vector():SpatialVector
		{
			return this;
		}
		
		public function get type():LineType
		{
			return _type;
		}
		
		public function isSame(line:Line):Boolean
		{
			return (a == line.a && b == line.b) || (a == line.b && b == line.a);
		}
		
		public function toString():String
		{
			return "[LINE " + a + ", " + b + "]";
		}
		
	}
}
