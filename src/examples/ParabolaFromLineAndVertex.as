package examples 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.parabola.MutableParabola;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.ParabolaDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class ParabolaFromLineAndVertex extends ExampleBaseSprite
	{
		private var vertexPaint:SolidPaint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var parabola:Parabola;
		private var parabolaDrawer:ParabolaDrawer;

		public function ParabolaFromLineAndVertex() 
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.x = 200;
			a.y = 250;
			
			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.x = 600;
			b.y = 250;
			
			c = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(c);
			c.x = 400;
			c.y = 350;
			
			line = new MutableLine(_context, a, b);
			lineDrawer = new LineDrawer(_context, line);
			
			parabola = new MutableParabola(_context, c, line);
			parabolaDrawer = new ParabolaDrawer(_context, parabola);
			
			addChild(lineDrawer);
			addChild(parabolaDrawer);
			
			addChild(a);			addChild(b);			addChild(c);
		}
	}
}
