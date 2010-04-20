package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.ui.generic.UIDrawer;
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.util.AngleHelper;

	import ui.Paint;
	import ui.util.UIArcHelper;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleSegmentDrawer extends UIDrawer
	{
		private var angles:AngleHelper;
		
		private var helper:UIArcHelper;
		
		private var _segment:CircleSegment;
		
		public function CircleSegmentDrawer(context:AS3GeometryContext, segment:CircleSegment, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_segment = segment);
			angles = new AngleHelper();
			helper = new UIArcHelper();
			invalidate();
		}
		
		public function get segment():CircleSegment
		{
			return _segment;
		}
		
		public function set segment(value:CircleSegment):void
		{
			if (_segment == value)
				return;
			
			removeDefinien(_segment);
			_segment = value;
			addDefinien(_segment);
			invalidate();
		}

		override protected function draw():void
		{
			var circle:Circle = _segment.from.circle;
			var c:Vertex = circle.center;
			var radius:Number = circle.radius;
			var angle:Number = _segment.from.angle;			var sweep:Number = _segment.angle;
			
			if (isNaN(c.x) || isNaN(c.y) || isNaN(angle) || isNaN(radius) || isNaN(sweep))
				return;
			
			helper.drawArc(graphics, c.x, c.y, radius, angle, sweep);
		}

	}
}
