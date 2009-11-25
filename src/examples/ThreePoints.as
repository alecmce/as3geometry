package examples 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Triangle;
	import as3geometry.geom2D.mutable.MutableCircle;
	import as3geometry.geom2D.mutable.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.mutable.MutableLine;
	import as3geometry.geom2D.mutable.MutableTriangle;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.TriangleDrawer;
	import as3geometry.geom2D.ui.UIVertex;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	import flash.display.Sprite;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ThreePoints extends Sprite 
	{
		private var vertexPaint:SolidPaint;		private var circlePaint:SolidPaint;		private var trianglePaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;		private var b:UIVertex;		private var c:UIVertex;
		
		private var circle:Circle;
		private var circleDrawer:CircleDrawer;
		
		private var circle2:Circle;		private var circleDrawer2:CircleDrawer;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var segment:Line;
		private var segmentDrawer:LineDrawer;
		
		private var ray:Line;
		private var rayDrawer:LineDrawer;
		
		private var triangle:Triangle;
		private var triangleDrawer:TriangleDrawer;
		
		public function ThreePoints()
		{
			init();	
		}
		
		private function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);			circlePaint = new SolidPaint(0x66FFEE00, 0xFF0000CD, 2);			trianglePaint = new SolidPaint(0x661E90FF, 0, -1);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(vertexPaint);
			dragMechanism.apply(a);			a.x = 80;
			a.y = 200;
			
			b = new UIVertex(vertexPaint);
			dragMechanism.apply(b);			b.x = 400;
			b.y = 180;
			
			c = new UIVertex(vertexPaint);			dragMechanism.apply(c);
			c.x = 300;
			c.y = 340;
			
			circle = new MutableCircle(a, 50);
			circleDrawer = new CircleDrawer(circle, circlePaint);
			
			circle2 = new MutableCircleWithRadialVertex(b, c);
			circleDrawer2 = new CircleDrawer(circle2, circlePaint);
			
			line = new MutableLine(a, b);
			lineDrawer = new LineDrawer(line);
			
			segment = new MutableLine(b, c, LineType.SEGMENT);
			segmentDrawer = new LineDrawer(segment);
			
			ray = new MutableLine(c, a, LineType.RAY);
			rayDrawer = new LineDrawer(ray);
			
			triangle = new MutableTriangle(a, b, c);
			triangleDrawer = new TriangleDrawer(triangle, trianglePaint);
			
			addChild(triangleDrawer);			addChild(circleDrawer);			addChild(lineDrawer);			addChild(segmentDrawer);			addChild(rayDrawer);			addChild(circleDrawer2);
			addChild(a);			addChild(b);			addChild(c);
		}
		
	}
}
