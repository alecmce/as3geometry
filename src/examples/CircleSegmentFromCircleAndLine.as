package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.intersection.IntersectionOfCircleAndLine;
	import as3geometry.geom2D.circle.MutableCircleSegment;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.CircleSegmentDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	import flash.display.Sprite;

	/**
	 * UI test verifies circle segment classes
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleSegmentFromCircleAndLine extends Sprite 
	{
		private var vertexPaint:SolidPaint;
		private var circlePaint:SolidPaint;
		private var rightSegmentPaint:SolidPaint;
		private var leftSegmentPaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		private var d:UIVertex;
		
		private var circle:Circle;
		private var circleDrawer:CircleDrawer;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var rightSegment:CircleSegment;
		private var rightSegmentDrawer:CircleSegmentDrawer;
		
		private var leftSegment:CircleSegment;
		private var leftSegmentDrawer:CircleSegmentDrawer;
		
		public function CircleSegmentFromCircleAndLine()
		{
			init();
		}
		
		private function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x0, 0xFF000000, 2);
			rightSegmentPaint = new SolidPaint(0x66FF0000, 0xFF, 2);
			leftSegmentPaint = new SolidPaint(0x661E90FF, 0xFF, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(vertexPaint);
			dragMechanism.apply(a);
			a.x = 80;
			a.y = 200;
			
			b = new UIVertex(vertexPaint);
			dragMechanism.apply(b);
			b.x = 400;
			b.y = 180;
			
			c = new UIVertex(vertexPaint);
			dragMechanism.apply(c);
			c.x = 275;
			c.y = 200;
			
			d = new UIVertex(vertexPaint);
			dragMechanism.apply(d);
			d.x = 450;
			d.y = 180;
			
			line = new MutableLine(a, b);
			lineDrawer = new LineDrawer(line);
			
			circle = new MutableCircleWithRadialVertex(c, d);
			circleDrawer = new CircleDrawer(circle, circlePaint);
			
			var intersection:IntersectionOfCircleAndLine = new IntersectionOfCircleAndLine(circle, line);
			rightSegment = new MutableCircleSegment(intersection.first, intersection.second, true);
			rightSegmentDrawer = new CircleSegmentDrawer(rightSegment, rightSegmentPaint);
			
			leftSegment = new MutableCircleSegment(intersection.first, intersection.second, false);
			leftSegmentDrawer = new CircleSegmentDrawer(leftSegment, leftSegmentPaint);
			
			addChild(lineDrawer);
			addChild(circleDrawer);
			addChild(rightSegmentDrawer);
			addChild(leftSegmentDrawer);
			
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
