package as3geometry.geom2D.immutable.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.Mutable;

	/**
	 * A vertex defined by the intersection of two lines. This is found by resolving the
	 * simultaneous equations:
	 * 
	 * a.a.x + a.vector.x * aMultiplier = b.a.x + b.vector.x * bMultiplier
	 * a.a.y + a.vector.y * aMultiplier = b.a.y + b.vector.y * bMultiplier
	 * 
	 * @see http://en.wikipedia.org/wiki/Line-line_intersection
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ImmutableTwoLinesIntersectionVertex implements Vertex
	{
		
		private var _a:Line;
		
		private var _b:Line;
		
		private var _x:Number;
		
		private var _y:Number;
		
		public function ImmutableTwoLinesIntersectionVertex(a:Line, b:Line)
		{
			_a = a;
			_b = b;
			
			if (_a is Mutable || _b is Mutable)
				throw new MutabilityError("The immutable TwoLinesIntersectionVertex is defined by a Mutable element");
			
			_x = Number.NaN;
			_y = Number.NaN;
			
			calculateIntersection();
		}
		
		/**
		 * @return One of the lines which define the vertex
		 */
		public function get a():Line
		{
			return _a;
		}
		
		/**
		 * @return One of the lines which define the vertex
		 */
		public function get b():Line
		{
			return _b;
		}
		
		/**
		 * @return The x-position of the vertex
		 */
		public function get x():Number
		{
			return _x;
		}
		
		/**
		 * @return The y-position of the vertex
		 */
		public function get y():Number
		{
			return _y;
		}
		
		/**
		 * calculate the intersection of the two lines a and b. If there is no
		 * intersection abort the calculation, which will leave the values of x
		 * and y as Number.NaN
		 */
		protected function calculateIntersection():void
		{
			if (!(_a.a && _a.b && _b.a && _b.b))
				return;
			
			var multipliers:Vector.<Number> = intersectionMultipliers();
			if (!multipliers)
				return;
				
			var aMultiplier:Number = multipliers[0];
			if (!doesIntersectionLieOnLineExtent(aMultiplier, _a.type))
				return;
			
			if (!doesIntersectionLieOnLineExtent(multipliers[1], _b.type))
				return;
			
			calculateIntersectionFromMultiplier(_a, aMultiplier);
		}
		
		private function calculateIntersectionFromMultiplier(line:Line, multiplier:Number):void
		{
			var v:SpatialVector = line.vector;
			_x = line.a.x + v.i * multiplier;
			_y = line.a.y + v.j * multiplier;
		}
		
		private function intersectionMultipliers():Vector.<Number>
		{
			var aVector:SpatialVector = _a.vector;
			var bVector:SpatialVector = _b.vector;
			
			var divisor:Number = (aVector.i * bVector.j - bVector.i * aVector.j);
			if (divisor == 0)
				return null;
		
			var multipliers:Vector.<Number> = new Vector.<Number>();
			var m:Number = (bVector.i * (_a.a.y - _b.a.y) - bVector.j * (_a.a.x - _b.a.x)) / divisor;
			
			multipliers[0] = m;
			multipliers[1] = (_a.a.x - _b.a.x + aVector.i * m) / bVector.i;
			
			return multipliers;
		}
		
		private function doesIntersectionLieOnLineExtent(multiplier:Number, lineType:LineType):Boolean
		{
			switch (lineType)
			{
				case LineType.SEGMENT:
					return multiplier >= 0 && multiplier <= 1;
					break;
				case LineType.RAY:
					return multiplier >= 0;
					break;
				default:
					return true;
					break;
			}
			
			return false;
		}
		
	}
}
