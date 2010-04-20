package as3geometry.geom2D.line 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;

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
	public class IntersectionOfTwoLinesVertex extends Mutable implements Vertex
	{
		
		private var _a:Line;
		private var _b:Line;
		private var _aMultiplier:Number;
		private var _bMultiplier:Number;
		protected var _x:Number;
		protected var _y:Number;
		
		protected var _invalidated:Boolean;
		
		public function IntersectionOfTwoLinesVertex(context:AS3GeometryContext, a:Line, b:Line)
		{
			super(context);
			addDefinien(_a = a);			addDefinien(_b = b);
			
			resolve();
		}
		
		public function get a():Line
		{
			return _a;
		}
		
		public function set a(a:Line):void
		{
			if (_a == a)
				return;
			
			removeDefinien(_a);
			_a = a;
			addDefinien(_a);
			invalidate();
		}
		
		public function get b():Line
		{
			return _b;
		}
		
		public function set b(b:Line):void
		{
			if (_b == b)
				return;
			
			removeDefinien(_b);
			_b = b;
			addDefinien(_b);
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
		
		public function get aMultiplier():Number
		{
			return _aMultiplier;
		}
		
		public function get bMultiplier():Number
		{
			return _bMultiplier;
		}

		
		/**
		 * calculate the intersection of the two lines a and b. If there is no
		 * intersection abort the calculation, which will leave the values of x
		 * and y as Number.NaN
		 */
		override public function resolve():void 
		{
			super.resolve();

			_x = Number.NaN;
			_y = Number.NaN;
			
			if (!(_a.a && _a.b && _b.a && _b.b))
				return;
			
			calculateMultipliers();
			if (isNaN(_aMultiplier) || isNaN(_bMultiplier))
				return;
				
			if (!_a.type.isValidPositionMultiplier(_aMultiplier))
				return;
			
			if (!_b.type.isValidPositionMultiplier(_bMultiplier))
				return;
			
			calculateIntersectionFromMultiplier(_a, _aMultiplier);
		}
		
		private function calculateIntersectionFromMultiplier(line:Line, multiplier:Number):void
		{
			var v:SpatialVector = line.vector;
			_x = line.a.x + v.i * multiplier;
			_y = line.a.y + v.j * multiplier;
		}
		
		private function calculateMultipliers():void
		{
			var aVector:SpatialVector = _a.vector;
			var bVector:SpatialVector = _b.vector;
			
			var divisor:Number = (aVector.i * bVector.j - bVector.i * aVector.j);
			if (divisor == 0)
			{
				_aMultiplier = Number.NaN;
				_bMultiplier = Number.NaN;
				return;
			}
		
			_aMultiplier = (bVector.i * (_a.a.y - _b.a.y) - bVector.j * (_a.a.x - _b.a.x)) / divisor;
			
			if (bVector.i)
				_bMultiplier = (_a.a.x - _b.a.x + aVector.i * _aMultiplier) / bVector.i;
			else
				_bMultiplier = (_a.a.y - _b.a.y + aVector.j * _aMultiplier) / bVector.j;
		}
	}
}
