package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

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
	public class IntersectionOfTwoLinesVertex implements Vertex, Mutable
	{
		
		private var _a:Line;
		
		private var _b:Line;
		
		private var _aMultiplier:Number;
		
		private var _bMultiplier:Number;
		
		private var _x:Number;
		
		private var _y:Number;
		
		private var _changed:ISignal;
		
		private var _invalidated:Boolean;
		
		public function IntersectionOfTwoLinesVertex(a:Line, b:Line)
		{
			_a = a;
			_b = b;
			_changed = new Signal(this, Mutable);
			
			if (_a is Mutable)
				Mutable(_a).changed.add(onDefinienChanged);
			
			if (_b is Mutable)
				Mutable(_b).changed.add(onDefinienChanged);
			
			calculateIntersection();
		}
		
		private function onDefinienChanged():void
		{
			_invalidated = true;
			_changed.dispatch();
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
			if (_invalidated)
				update();
			
			return _x;
		}
		
		/**
		 * @return The y-position of the vertex
		 */
		public function get y():Number
		{
			if (_invalidated)
				update();
			
			return _y;
		}
		
		public function get aMultiplier():Number
		{
			if (_invalidated)
				update();
			
			return _aMultiplier;
		}
		
		public function get bMultiplier():Number
		{
			if (_invalidated)
				update();
			
			return _bMultiplier;
		}
		
		
		private function update():void
		{
			_invalidated = false;
			calculateIntersection();
		}
		
		/**
		 * calculate the intersection of the two lines a and b. If there is no
		 * intersection abort the calculation, which will leave the values of x
		 * and y as Number.NaN
		 */
		private function calculateIntersection():void
		{
			_x = Number.NaN;
			_y = Number.NaN;
			
			if (!(_a.a && _a.b && _b.a && _b.b))
				return;
			
			calculateMultipliers();
			if (isNaN(_aMultiplier) || isNaN(_bMultiplier))
				return;
						
			if (!doesIntersectionLieOnLineExtent(_aMultiplier, _a.type))
				return;
			
			if (!doesIntersectionLieOnLineExtent(_bMultiplier, _b.type))
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
		
		public function get changed():ISignal
		{
			return _changed;
		}
		
	}
}
