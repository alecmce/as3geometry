package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.circle.MutableCircle;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.polygons.MutableTriangle;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.TriangleDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	/**
	 * An example of the current state of the as3geometry library.
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ThreePoints extends ExampleBaseSprite 
	{
		private var vertexPaint:SolidPaint;
		private var circlePaint:SolidPaint;
		private var trianglePaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		
		private var circle:Circle;
		private var circleDrawer:CircleDrawer;
		
		private var circle2:Circle;
		private var circleDrawer2:CircleDrawer;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var segment:Line;
		private var segmentDrawer:LineDrawer;
		
		private var ray:Line;
		private var rayDrawer:LineDrawer;
		
		private var triangle:Triangle;
		private var triangleDrawer:TriangleDrawer;
		
		override protected function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x66FFEE00, 0xFF0000CD, 2);
			trianglePaint = new SolidPaint(0x661E90FF, 0, -1);
			
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
			c.y = 340;
			
			circle = new MutableCircle(_context, a, 50);
			circleDrawer = new CircleDrawer(_context, circle, circlePaint);
			
			circle2 = new MutableCircleWithRadialVertex(_context, b, c);
			circleDrawer2 = new CircleDrawer(_context, circle2, circlePaint);
			
			line = new MutableLine(_context, a, b);
			lineDrawer = new LineDrawer(_context, line);
			
			segment = new MutableLine(_context, b, c, LineType.SEGMENT);
			segmentDrawer = new LineDrawer(_context, segment);
			
			ray = new MutableLine(_context, c, a, LineType.RAY);
			rayDrawer = new LineDrawer(_context, ray);
			
			triangle = new MutableTriangle(_context, a, b, c);
			triangleDrawer = new TriangleDrawer(_context, triangle, trianglePaint);
			
			addChild(triangleDrawer);
			addChild(circleDrawer);
			addChild(lineDrawer);
			addChild(segmentDrawer);
			addChild(rayDrawer);
			addChild(circleDrawer2);
			addChild(a);
			addChild(b);
			addChild(c);
		}
		
	}
}
