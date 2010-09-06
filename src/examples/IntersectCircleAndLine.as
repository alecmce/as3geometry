package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.intersection.IntersectionOfCircleAndLine;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.VertexDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import alecmce.ui.interactive.DragMechanism;
	import alecmce.ui.paint.SolidPaint;

	/**
	 * UI test verifies IntersectionOfCircleAndLine class
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectCircleAndLine extends ExampleBaseSprite 
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
		
		override protected function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x66FFEE00, 0xFF0000CD, 2);
			intersectionPaint = new SolidPaint(0xFF0000CD, 0xFF, 2);
			
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
			c.x = 300;
			c.y = 140;
			
			d = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(d);
			d.x = 340;
			d.y = 260;
			
			line = new MutableLine(_context, a, b, LineType.SEGMENT);
			lineDrawer = new LineDrawer(_context, line);
			
			circle = new MutableCircleWithRadialVertex(_context, c, d);
			circleDrawer = new CircleDrawer(_context, circle, circlePaint);
			
			intersections = new IntersectionOfCircleAndLine(_context, circle, line);
			n = new VertexDrawer(_context, intersections.first, 5, intersectionPaint);			m = new VertexDrawer(_context, intersections.second, 5, intersectionPaint);
						addChild(circleDrawer);			addChild(lineDrawer);
			
			addChild(n);			addChild(m);
			
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
