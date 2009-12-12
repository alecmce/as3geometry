package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.util.AngleHelper;

	import ui.Paint;
	import ui.util.UIArcHelper;

	import flash.events.Event;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleSegmentDrawer extends GeneralDrawer
	{
		private var angles:AngleHelper;
		
		private var helper:UIArcHelper;
		
		private var _segment:CircleSegment;
		
		public function CircleSegmentDrawer(segment:CircleSegment, paint:Paint = null)
		{
			_segment = segment;
			if (_segment is Mutable)
				Mutable(_segment).changed.add(onDefinienChanged);
			
			angles = new AngleHelper();
			helper = new UIArcHelper();
			
			super(paint);
		}
		
		public function get segment():CircleSegment
		{
			return _segment;
		}
		
		public function set segment(value:CircleSegment):void
		{
			if (_segment == value)
				return;
			
			if (_segment is Mutable)
				Mutable(_segment).changed.remove(onDefinienChanged);
			
			_segment = value;
			
			if (_segment is Mutable)
				Mutable(_segment).changed.add(onDefinienChanged);
				
			addEventListener(Event.ENTER_FRAME, redraw);		}

		override protected function draw():void
		{
			var c:Vertex = _segment.circle.center;
			var radius:Number = _segment.circle.radius;
			var angle:Number = _segment.angle;			var sweep:Number = _segment.sweep;
			
			if (isNaN(c.x) || isNaN(c.y) || isNaN(angle) || isNaN(radius) || isNaN(sweep))
				return;
			
			helper.drawArc(graphics, c.x, c.y, radius, angle, sweep);
		}

	}
}
