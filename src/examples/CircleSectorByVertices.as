package examples
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSector;
	import as3geometry.geom2D.circle.MutableCircleSector;
	import as3geometry.geom2D.circle.MutableCircleWithRadialVertex;
	import as3geometry.geom2D.ui.CircleDrawer;
	import as3geometry.geom2D.ui.CircleSectorDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;
	import as3geometry.geom2D.ui.vertices.UIVertexOnCircle;

	import alecmce.ui.interactive.DragMechanism;
	import alecmce.ui.paint.SolidPaint;

	/**
	 * UI test verifies MutableCircleSector class
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class CircleSectorByVertices extends ExampleBaseSprite
	{
		private var vertexPaint:SolidPaint;
		private var circlePaint:SolidPaint;
		private var rightSectorPaint:SolidPaint;
		private var leftSectorPaint:SolidPaint;

		private var dragMechanism:DragMechanism;

		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertexOnCircle;
		private var d:UIVertexOnCircle;

		private var circle:Circle;
		private var circleDrawer:CircleDrawer;

		private var rightSector:CircleSector;
		private var rightSectorDrawer:CircleSectorDrawer;

		private var leftSector:CircleSector;
		private var leftSectorDrawer:CircleSectorDrawer;


		override protected function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x0, 0xFF000000, 2);
			rightSectorPaint = new SolidPaint(0x66FF0000, 0xFF, 2);
			leftSectorPaint = new SolidPaint(0x661E90FF, 0xFF, 2);

			dragMechanism = new DragMechanism();

			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.x = 275;
			a.y = 200;

			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.x = 450;
			b.y = 180;

			circle = new MutableCircleWithRadialVertex(_context, a, b);
			circleDrawer = new CircleDrawer(_context, circle, circlePaint);

			c = new UIVertexOnCircle(_context, circle, Math.PI * 0.2, vertexPaint);
			dragMechanism.apply(c);

			d = new UIVertexOnCircle(_context, circle, Math.PI, vertexPaint);
			dragMechanism.apply(d);

			rightSector = new MutableCircleSector(_context, c, d, true);
			rightSectorDrawer = new CircleSectorDrawer(_context, rightSector, rightSectorPaint);

			leftSector = new MutableCircleSector(_context, c, d, false);
			leftSectorDrawer = new CircleSectorDrawer(_context, leftSector, leftSectorPaint);

			addChild(circleDrawer);
			addChild(rightSectorDrawer);
			addChild(leftSectorDrawer);

			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
