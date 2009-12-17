package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSegment;
	import as3geometry.geom2D.circle.MutableCircleSegment;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.CircleSegmentDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;
	import as3geometry.geom2D.ui.vertices.UIVertexOnCircle;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	import flash.display.Sprite;

	/**
	 * UI test verifies MutableVertexOnCircle class
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleSegmentByVertices extends Sprite 
	{
		private var vertexPaint:SolidPaint;
		private var circlePaint:SolidPaint;
		private var rightSegmentPaint:SolidPaint;		private var leftSegmentPaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertexOnCircle;
		private var d:UIVertexOnCircle;
		
		private var circle:Circle;
		private var circleDrawer:CircleDrawer;
		
		private var rightSegment:CircleSegment;
		private var rightSegmentDrawer:CircleSegmentDrawer;
		
		private var leftSegment:CircleSegment;
		private var leftSegmentDrawer:CircleSegmentDrawer;
		
		public function CircleSegmentByVertices()
		{
			init();
		}
		
		private function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x0, 0xFF000000, 2);
			rightSegmentPaint = new SolidPaint(0x66FF0000, 0xFF, 2);			leftSegmentPaint = new SolidPaint(0x661E90FF, 0xFF, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(vertexPaint);
			dragMechanism.apply(a);
			a.x = 275;
			a.y = 200;
			
			b = new UIVertex(vertexPaint);
			dragMechanism.apply(b);
			b.x = 450;
			b.y = 180;
			
			circle = new MutableCircleWithRadialVertex(a, b);
			circleDrawer = new CircleDrawer(circle, circlePaint);
			
			c = new UIVertexOnCircle(circle, Math.PI * 0.2, vertexPaint);
			c.angle = Math.PI;
			dragMechanism.apply(c);
			
			d = new UIVertexOnCircle(circle, Math.PI, vertexPaint);
			d.angle = Math.PI / 2;
			dragMechanism.apply(d);
			
			rightSegment = new MutableCircleSegment(c, d, true);
			rightSegmentDrawer = new CircleSegmentDrawer(rightSegment, rightSegmentPaint);
			
			leftSegment = new MutableCircleSegment(c, d, false);
			leftSegmentDrawer = new CircleSegmentDrawer(leftSegment, leftSegmentPaint);
			
			addChild(circleDrawer);
			addChild(rightSegmentDrawer);			addChild(leftSegmentDrawer);
			
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
