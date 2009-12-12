package as3geometry.geom2D.mutable.circle 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.intersection.IntersectionVerticesOfCircleAndLine;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.mutable.abstract.AbstractMutable;
	import as3geometry.geom2D.util.AngleHelper;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionCircleSegmentOfCircleAndLine extends AbstractMutable implements CircleSegment
	{
		private static const TWOPI:Number = Math.PI * 2;
		
		private var _helper:AngleHelper;
		
		private var _intersection:IntersectionVerticesOfCircleAndLine;
		
		private var _isRight:Boolean;
		
		private var _invalidated:Boolean;
		
		private var _angle:Number;
		
		private var _sweep:Number;

		public function IntersectionCircleSegmentOfCircleAndLine(intersection:IntersectionVerticesOfCircleAndLine, isRight:Boolean)
		{
			addDefinien(_intersection = intersection);
			_isRight = isRight;
			
			_helper = new AngleHelper();
		}
		
		public function get circle():Circle
		{
			return _intersection.circle;
		}
		
		public function get angle():Number
		{
			if (_invalidated)
				update();
				
			return _angle;
		}
		
		public function get sweep():Number
		{
			if (_invalidated)
				update();
			
			return _sweep;
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
			
			var c:Vertex = _intersection.circle.center;
			var a:Vertex = _intersection.first;
			var b:Vertex = _intersection.second;
			
			if (isNaN(b.x) || isNaN(b.y))
			{
				_angle = Number.NaN;
				_sweep = Number.NaN;
				return;
			}
			
			var dX:Number = a.x - c.x;			var dY:Number = a.y - c.y;
			
			_angle = Math.atan2(dY, dX);
			_sweep = _helper.directedAngleFromVertices(c, a, b);
			if (_isRight == _sweep < 0)
				_sweep = TWOPI + _sweep;
		}
		
	}
}
