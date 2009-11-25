package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutableVertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Defines a triangle on a Cartesian plane by three vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableTriangle implements Triangle, Mutable
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the triangle */
		private var _a:Vertex;
				/** a vertex of the triangle */
		private var _b:Vertex;
				/** a vertex of the triangle */
		private var _c:Vertex;
		
		private var _changed:ISignal;

		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		public function MutableTriangle(a:Vertex = null, b:Vertex = null, c:Vertex = null)
		{
			_a = a ? a : new ImmutableVertex(0, 0);			_b = b ? b : new ImmutableVertex(0, 0);			_c = c ? c : new ImmutableVertex(0, 0);
			_changed = new Signal(this, Mutable);
			
			if (_a is Mutable)
				Mutable(_a).changed.add(onDefinienChanged);			
			if (_b is Mutable)
				Mutable(_b).changed.add(onDefinienChanged);			
			if (_c is Mutable)
				Mutable(_c).changed.add(onDefinienChanged);
		}
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}

		public function get a():Vertex
		{
			return _a;
		}
		
		public function get b():Vertex
		{
			return _b;
		}
		
		public function get c():Vertex
		{
			return _c;
		}

		public function toString():String
		{
			return "[TRIANGLE " + _a + ", " + _b + ", " + _c + "]";
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
