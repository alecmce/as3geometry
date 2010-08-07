package examples 
{
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.line.MutableLine;
	import as3geometry.geom2D.parabola.MutableParabola;
	import as3geometry.geom2D.ui.LineDrawer;
	import as3geometry.geom2D.ui.ParabolaDrawer;
	import as3geometry.geom2D.ui.vertices.UIVertex;

	import ui.Paint;
	import ui.interactive.DragMechanism;
	import ui.paint.SolidPaint;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class ParabolaFromSegmentAndVertex extends ExampleBaseSprite
	{
		private var vertexPaint:SolidPaint;
		private var linePaint:Paint;
		
		private var dragMechanism:DragMechanism;
		
		private var a:UIVertex;
		private var b:UIVertex;
		private var c:UIVertex;
		
		private var line:Line;
		private var lineDrawer:LineDrawer;
		
		private var parabola:Parabola;
		private var parabolaDrawer:ParabolaDrawer;

		public function ParabolaFromSegmentAndVertex() 
		{
			vertexPaint = new SolidPaint(0xFFFF0000, 0xFF000000, 2);
			linePaint = new SolidPaint(0, 0xFF000000, 2);
			
			dragMechanism = new DragMechanism();
			
			a = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(a);
			a.x = Math.random() * stage.stageWidth;
			a.y = Math.random() * stage.stageHeight;
			
			b = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(b);
			b.x = Math.random() * stage.stageWidth;
			b.y = Math.random() * stage.stageHeight;
			
			c = new UIVertex(_context, vertexPaint);
			dragMechanism.apply(c);
			c.x = Math.random() * stage.stageWidth;
			c.y = Math.random() * stage.stageHeight;
			
			line = new MutableLine(_context, a, b, LineType.SEGMENT);
			lineDrawer = new LineDrawer(_context, line);
			
			parabola = new MutableParabola(_context, c, line);
			parabolaDrawer = new ParabolaDrawer(_context, parabola, linePaint);
			
			addChild(lineDrawer);
			addChild(parabolaDrawer);
			
			addChild(a);			addChild(b);			addChild(c);
		}
	}
}
