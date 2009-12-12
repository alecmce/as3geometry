package examples 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.polygons.MutablePolygon;
	import as3geometry.geom2D.polygons.intersection.IntersectionOfTwoPolygons;
	import as3geometry.geom2D.ui.PolygonDrawer;
	import as3geometry.geom2D.ui.PolygonsDrawer;
	import as3geometry.geom2D.ui.UIVertex;

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
	public class IntersectTwoQuadrilateralsWithOppositeDirections extends Sprite 
	{
		private var vertexPaint:SolidPaint;
		private var intersectionPaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;		private var d:UIVertex;
		
		private var e:UIVertex;
		private var f:UIVertex;
		private var g:UIVertex;
		private var h:UIVertex;
		
		private var polygonA:Polygon;
		private var polygonADrawer:PolygonDrawer;

		private var polygonB:Polygon;
		private var polygonBDrawer:PolygonDrawer;
		
		private var intersections:IntersectionOfTwoPolygons;
		private var intersectionsDrawer:PolygonsDrawer;		
		public function IntersectTwoQuadrilateralsWithOppositeDirections()
		{
			init();
		}
		
		private function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			intersectionPaint = new SolidPaint(0x66FFEE00, 0xFF000000, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(vertexPaint);
			dragMechanism.apply(a);
			a.x = 100;
			a.y = 50;
			
			b = new UIVertex(vertexPaint);
			dragMechanism.apply(b);
			b.x = 300;
			b.y = 50;
			
			c = new UIVertex(vertexPaint);
			dragMechanism.apply(c);
			c.x = 300;
			c.y = 250;
			
			d = new UIVertex(vertexPaint);
			dragMechanism.apply(d);
			d.x = 100;
			d.y = 250;
			
			e = new UIVertex(vertexPaint);
			dragMechanism.apply(e);
			e.x = 200;
			e.y = 150;
			
			f = new UIVertex(vertexPaint);
			dragMechanism.apply(f);
			f.x = 200;
			f.y = 350;
			
			g = new UIVertex(vertexPaint);
			dragMechanism.apply(g);
			g.x = 400;
			g.y = 350;
			
			h = new UIVertex(vertexPaint);
			dragMechanism.apply(h);
			h.x = 400;
			h.y = 150;
			
			var vector:Array;
			
			vector = [a,b,c,d];
			polygonA = new MutablePolygon(vector);
			polygonADrawer = new PolygonDrawer(polygonA);
			
			vector = [e,f,g,h];
			polygonB = new MutablePolygon(vector);
			polygonBDrawer = new PolygonDrawer(polygonB);
			
			intersections = new IntersectionOfTwoPolygons(polygonA, polygonB);
			intersectionsDrawer = new PolygonsDrawer(intersections, intersectionPaint);
						addChild(intersectionsDrawer);			addChild(polygonADrawer);			addChild(polygonBDrawer);
			
			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
			
			addChild(e);
			addChild(f);
			addChild(g);
			addChild(h);
		}
	}
}
