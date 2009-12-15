package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.intersection.IntersectionOfCircleAndLine;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;
	import as3geometry.geom2D.ui.VertexDrawer;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	import flash.display.Sprite;

	/**
	 * UI test verifies IntersectionOfCircleAndLine class
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectCircleAndLine extends Sprite 
	{
		private var vertexPaint:SolidPaint;
		private var intersectionPaint:SolidPaint;
		private var circlePaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;		private var d:UIVertex;
		
		private var circle:Circle;
		private var circleDrawer:CircleDrawer;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var intersections:IntersectionOfCircleAndLine;
		
		private var n:VertexDrawer;		private var m:VertexDrawer;
		
		public function IntersectCircleAndLine()
		{
			init();
		}
		
		private function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x66FFEE00, 0xFF0000CD, 2);
			intersectionPaint = new SolidPaint(0xFF0000CD, 0xFF, 2);
			
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
			c.x = 300;
			c.y = 140;
			
			d = new UIVertex(vertexPaint);
			dragMechanism.apply(d);
			d.x = 340;
			d.y = 260;
			
			line = new MutableLine(a, b, LineType.SEGMENT);
			lineDrawer = new LineDrawer(line);
			
			circle = new MutableCircleWithRadialVertex(c, d);
			circleDrawer = new CircleDrawer(circle, circlePaint);
			
			intersections = new IntersectionOfCircleAndLine(circle, line);
			n = new VertexDrawer(intersections.first, 5, intersectionPaint);			m = new VertexDrawer(intersections.second, 5, intersectionPaint);
						addChild(circleDrawer);			addChild(lineDrawer);
			
			addChild(n);			addChild(m);
			
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
