package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.circle.MutableCircleSegment;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.intersection.IntersectionOfCircleAndLine;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.CircleSegmentDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import alecmce.ui.interactive.DragMechanism;
	import alecmce.ui.paint.SolidPaint;

	/**
	 * UI test verifies circle segment classes
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class CircleSegmentFromCircleAndLine extends ExampleBaseSprite 
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
		
		override protected function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x0, 0xFF000000, 2);
			rightSegmentPaint = new SolidPaint(0x66FF0000, 0xFF, 2);
			leftSegmentPaint = new SolidPaint(0x661E90FF, 0xFF, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.x = 80;
			a.y = 200;
			
			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.x = 400;
			b.y = 180;
			
			c = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(c);
			c.x = 275;
			c.y = 200;
			
			d = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(d);
			d.x = 450;
			d.y = 180;
			
			line = new MutableLine(_context, a, b);
			lineDrawer = new LineDrawer(_context, line);
			
			circle = new MutableCircleWithRadialVertex(_context, c, d);
			circleDrawer = new CircleDrawer(_context, circle, circlePaint);
			
			var intersection:IntersectionOfCircleAndLine = new IntersectionOfCircleAndLine(_context, circle, line);
			rightSegment = new MutableCircleSegment(_context, intersection.first, intersection.second, true);
			rightSegmentDrawer = new CircleSegmentDrawer(_context, rightSegment, rightSegmentPaint);
			
			leftSegment = new MutableCircleSegment(_context, intersection.first, intersection.second, false);
			leftSegmentDrawer = new CircleSegmentDrawer(_context, leftSegment, leftSegmentPaint);
			
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
