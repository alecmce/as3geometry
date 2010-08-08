package examples 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.parabola.MutableParabola;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.ParabolaDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;
	import as3geometry.geom2D.ui.vertices.UIVertexOnParabola;

	import ui.Paint;
	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="640", height="480")]
	public class VertexOnParabolaExample extends ExampleBaseSprite
	{
		private var vertexPaint:SolidPaint;
		private var linePaint:Paint;
		private var constrainedVertexPaint:Paint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		private var d:UIVertexOnParabola;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var parabola:Parabola;
		private var parabolaDrawer:ParabolaDrawer;

		public function VertexOnParabolaExample()
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			linePaint = new SolidPaint(0, 0xFF000000, 2);
			constrainedVertexPaint = new SolidPaint(0xFFFFEE00, 0xFF000000, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.set(100, 300);
			
			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.set(340,380);
			
			c = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(c);
			c.set(320 + 50, 240 - 50);
			
			line = new MutableLine(_context, a, b);
			lineDrawer = new LineDrawer(_context, line);
			
			parabola = new MutableParabola(_context, c, line);
			parabolaDrawer = new ParabolaDrawer(_context, parabola, linePaint);

			d = new UIVertexOnParabola(_context, parabola, 0.5, constrainedVertexPaint);
			dragMechanism.apply(d);
			
			addChild(lineDrawer);
			addChild(parabolaDrawer);
			
			addChild(a);			addChild(b);			addChild(c);			addChild(d);
		}
	}
}
