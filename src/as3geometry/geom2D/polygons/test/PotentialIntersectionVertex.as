package as3geometry.geom2D.polygons.test
{
	import alecmce.invalidation.Invalidates;
	import alecmce.invalidation.signals.InvalidationSignal;

	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.line.IntersectionOfTwoLinesVertex;

	import org.osflash.signals.Signal;

	/**
	 * A vertex that lies on the intersection of two vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class PotentialIntersectionVertex extends ExpandedPolygonVertex implements Invalidates
	{
		private var _context:AS3GeometryContext;

		private var _intersection:IntersectionOfTwoLinesVertex;

		private var _invalidated:InvalidationSignal;

		private var _realityChanged:Signal;

		private var _aIndex:uint;

		private var _bIndex:uint;
		private var _isInvalid:Boolean;

		public function PotentialIntersectionVertex(context:AS3GeometryContext, a:Line, b:Line, aIndex:uint, bIndex:uint)
		{
			_context = context;
			_invalidated = new InvalidationSignal();

			_intersection = new IntersectionOfTwoLinesVertex(context, a, b);
			context.invalidationManager.addDependency(_intersection, this);

			_aIndex = aIndex;			_bIndex = bIndex;

			_realityChanged = new Signal(PotentialIntersectionVertex);
			resolve();
		}

		public function toString() : String
		{
			var str:String = "Intersection: (@X@,@Y@)";
			str = str.replace("@X@", x);			str = str.replace("@Y@", y);

			return str;
		}

		public function get realityChanged():Signal
		{
			return _realityChanged;
		}

		override public function get x():Number
		{
			return _intersection.x;
		}

		override public function get y():Number
		{
			return _intersection.y;
		}

		public function get a():Line
		{
			return _intersection.a;
		}

		public function get b():Line
		{
			return _intersection.b;
		}

		public function invalidate(resolve:Boolean = false):void
		{
			_invalidated.dispatch(this);
			_isInvalid = true;
		}

		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}

		public function get isInvalid():Boolean
		{
			return _isInvalid;
		}

		public function resolve():void
		{
			_isInvalid = false;

			var x:Number = _intersection.x;
			var y:Number = _intersection.y;

			var newIsIntersection:Boolean = !isNaN(x) && !isNaN(y);
			var realValueHasChanged:Boolean = isReal != newIsIntersection;

			isReal = newIsIntersection;

			if (isReal)
			{
				positionOnPolygonAAsCycle = _aIndex + _intersection.aMultiplier;
				positionOnPolygonBAsCycle = _bIndex + _intersection.bMultiplier;
			}
			else
			{
				positionOnPolygonAAsCycle = Number.NaN;
				positionOnPolygonBAsCycle = Number.NaN;
			}

			if (realValueHasChanged)
				_realityChanged.dispatch(this);
		}

		public function get context():AS3GeometryContext
		{
			return _context;
		}
	}
}
