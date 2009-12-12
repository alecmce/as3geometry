package as3geometry.geom2D.circle 
{
	import as3geometry.Mutable;
	import as3geometry.abstract.AbstractMutable;
	import as3geometry.geom2D.CircleSegment;
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
	public class MutableCircleSegment extends AbstractMutable implements CircleSegment
	{
		private static const TWOPI:Number = Math.PI * 2;
		
		private var _helper:AngleHelper;
		
		private var _from:VertexOnCircle;
				private var _to:VertexOnCircle;
		
		private var _isRight:Boolean;
		
		private var _invalidated:Boolean;
		
		private var _angle:Number;
		
		public function MutableCircleSegment(from:VertexOnCircle, to:VertexOnCircle, isRight:Boolean)
		{
			if (from.circle != to.circle)
				throw new SegmentDefinitionError("The from and to vertices must lie on the same circle");

			addDefinien(_from = from);
			addDefinien(_to = to);
			
			_isRight = isRight;
			_helper = new AngleHelper();
			update();
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
			_changed.dispatch(this);
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
			_changed.dispatch(this);
		}
		
		public function get angle():Number
		{
			if (_invalidated)
				update();
				
			return _angle;
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			mutable; // ignore
			
			_invalidated = true;
			_changed.dispatch(this);
		}
		
		private function update():void
		{
			_invalidated = false;
			
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
