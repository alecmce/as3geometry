package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.immutable.ImmutableVertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Defines a line on a Cartesian plane by two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableLine implements Line, SpatialVector, Mutable
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the line */
		private var _a:Vertex;
		
		/** a vertex of the line */
		private var _b:Vertex;

		/** the line type */
		private var _type:LineType;
		
		private var _changed:ISignal;
		
		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/
		
		
		/**
		 * Class Constructor
		 * 
		 * @param a A vertex of the line
		 * @param b A vertex of the line
		 */
		public function MutableLine(a:Vertex = null, b:Vertex = null, type:LineType = null)
		{
			_a = a ? a : new ImmutableVertex(0, 0);
			_b = b ? b : new ImmutableVertex(0, 0);
			_type = type ? type : LineType.LINE;
			_changed = new Signal(this, Mutable);
			
			if (_a is Mutable)				Mutable(_a).changed.add(onDefinienChanged);
			
			if (_b is Mutable)
				Mutable(_b).changed.add(onDefinienChanged);
		}
		
		public function get a():Vertex
		{
			return _a;
		}
		
		public function get b():Vertex
		{
			return _b;
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
		
		/**
		 * determine whether two lines are the same iff they share the same
		 * determinant vertices
		 * 
		 * @param line The line to compare this line with
		 * @return Whether the two lines are the same
		 */
		public function isSame(line:Line):Boolean
		{
			return (a == line.a && b == line.b) || (a == line.b && b == line.a);
		}
		
		/**
		 * @return A user-readable string describing this line
		 */
		public function toString():String
		{
			return "[LINE " + a + ", " + b + "]";
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}
		
	}
}
