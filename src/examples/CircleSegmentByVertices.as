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

	import alecmce.ui.interactive.DragMechanism;
	import alecmce.ui.paint.SolidPaint;

	/**
	 * UI test verifies MutableVertexOnCircle class
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class CircleSegmentByVertices extends ExampleBaseSprite
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


		override protected function init():void
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			circlePaint = new SolidPaint(0x0, 0xFF000000, 2);
			rightSegmentPaint = new SolidPaint(0x66FF0000, 0xFF, 2);			leftSegmentPaint = new SolidPaint(0x661E90FF, 0xFF, 2);

			dragMechanism = new DragMechanism();

			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.x = 275;
			a.y = 200;

			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.x = 450;
			b.y = 180;

			trace("<Constructor>");			circle = new MutableCircleWithRadialVertex(_context, a, b);			trace("</Constructor>");
			circleDrawer = new CircleDrawer(_context, circle, circlePaint);

			c = new UIVertexOnCircle(_context, circle, Math.PI * 0.2, vertexPaint);
			dragMechanism.apply(c);

			d = new UIVertexOnCircle(_context, circle, Math.PI, vertexPaint);
			dragMechanism.apply(d);

			rightSegment = new MutableCircleSegment(_context, c, d, true);
			rightSegmentDrawer = new CircleSegmentDrawer(_context, rightSegment, rightSegmentPaint);

			leftSegment = new MutableCircleSegment(_context, c, d, false);
			leftSegmentDrawer = new CircleSegmentDrawer(_context, leftSegment, leftSegmentPaint);

			addChild(circleDrawer);
			addChild(rightSegmentDrawer);			addChild(leftSegmentDrawer);

			addChild(a);
			addChild(b);
			addChild(c);
			addChild(d);
		}
	}
}
