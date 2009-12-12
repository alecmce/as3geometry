package examples 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.intersection.IntersectionOfTwoLinesVertex;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.UIVertex;
	import as3geometry.geom2D.ui.VertexDrawer;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	import flash.display.Sprite;

	/**
	 * UI test verifies IntersectionOfTwoLinesVertex
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectLineAndLine extends Sprite 
	{
		private var vertexPaint:SolidPaint;
		private var intersectionPaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		private var d:UIVertex;
		
		private var lineA:Line;
		private var lineADrawer:LineDrawer;
		
		private var lineB:Line;
		private var lineBDrawer:LineDrawer;
		
		private var intersection:IntersectionOfTwoLinesVertex;
		private var n:VertexDrawer;
		
		public function IntersectLineAndLine()
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
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
			
			lineA = new MutableLine(a, b, LineType.SEGMENT);
			lineADrawer = new LineDrawer(lineA);
			
			lineB = new MutableLine(c, d, LineType.RAY);
			lineBDrawer = new LineDrawer(lineB);
			
			intersection = new IntersectionOfTwoLinesVertex(lineA, lineB);
			n = new VertexDrawer(intersection, 5, intersectionPaint);
			
			addChild(lineADrawer);
			addChild(lineBDrawer);
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
			
			addChild(n);
		}
	}
}
