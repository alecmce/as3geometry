package as3geometry.geom2D.polygons 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.Vertex;

	/**
	 * Defines a triangle on a Cartesian plane by three vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableTriangle extends Mutable implements Triangle
	{
		private var _a:Vertex;
		private var _b:Vertex;
		private var _c:Vertex;
		
		public function MutableTriangle(context:AS3GeometryContext, a:Vertex, b:Vertex, c:Vertex)
		{
			super(context);
			addDefinien(_a = a);			addDefinien(_b = b);
			addDefinien(_c = c);
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

		public function get c():Vertex
		{
			return _c;
		}
		
		public function set c(c:Vertex):void
		{
			if (_c == c)
				return;
			
			removeDefinien(_c);
			_c = c;
			addDefinien(_c);
			invalidate();
		}

		public function toString():String
		{
			return "[TRIANGLE " + _a + ", " + _b + ", " + _c + "]";
		}
	}
}
