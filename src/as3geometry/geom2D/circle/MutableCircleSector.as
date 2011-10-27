package as3geometry.geom2D.circle
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.CircleSector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;
	import as3geometry.geom2D.circle.errors.SegmentDefinitionError;
	import as3geometry.geom2D.util.AngleHelper;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableCircleSector extends Mutable implements CircleSector
	{
		private static const TWOPI:Number = Math.PI * 2;

		private var _helper:AngleHelper;

		private var _from:VertexOnCircle;
				private var _to:VertexOnCircle;

		private var _isRight:Boolean;

		private var _angle:Number;

		public function MutableCircleSector(context:AS3GeometryContext, from:VertexOnCircle, to:VertexOnCircle, isRight:Boolean)
		{
			super(context);

			if (from.circle != to.circle)
				throw new SegmentDefinitionError("The from and to vertices must lie on the same circle");

			addDefinien(_from = from);
			addDefinien(_to = to);

			_isRight = isRight;
			_helper = new AngleHelper();
			invalidate(true);
		}

		public function get from():VertexOnCircle
		{
			return _from;
		}

		public function set from(from:VertexOnCircle):void
		{
			if (_from == from)
				return;

			if (from.circle != _to.circle)
				throw new SegmentDefinitionError("The from and to vertices must lie on the same circle");

			_from = from;
			invalidate();
		}

		public function get to():VertexOnCircle
		{
			return _to;
		}

		public function set to(to:VertexOnCircle):void
		{
			if (_to == to)
				return;

			if (to.circle != _from.circle)
				throw new SegmentDefinitionError("The from and to vertices must lie on the same circle");

			_to = to;
			invalidate();
		}

		public function get angle():Number
		{
			return _angle;
		}

		override public function resolve():void
		{
			super.resolve();

			if (isNaN(_from.x) || isNaN(_from.y) || isNaN(_to.x) || isNaN(_to.y))
			{
				_angle = Number.NaN;
				return;
			}

			var center:Vertex = _from.circle.center;
			_angle = _helper.directedAngleFromVertices(center, _from, _to);
			if (_isRight == _angle < 0)
				_angle = TWOPI + _angle;
		}

	}
}
