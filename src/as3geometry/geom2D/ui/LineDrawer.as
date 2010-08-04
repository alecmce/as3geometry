package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.ui.generic.UIDrawer;
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	import flash.display.Graphics;
	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class LineDrawer extends UIDrawer
	{
		
		private var _line:Line;
		
		private var _diagonal:Number;
		
		private var _drawPending:Boolean;
		
		public function LineDrawer(context:AS3GeometryContext, line:Line, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_line = line);
			
			_drawPending = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_diagonal = calculateDiagonal();
			
			if (_drawPending)
				draw();
		}
		
		private function calculateDiagonal():Number
		{
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			return Math.sqrt(w * w + h * h);
		}

		public function get line():Line
		{
			return _line;
		}
		
		public function set line(value:Line):void
		{
			if (_line == value)
				return;
			
			removeDefinien(_line);
			addDefinien(_line = value);
			invalidate();
		}

		override protected function draw():void
		{
			if (!stage)
			{
				_drawPending = true;
				return;
			}
			
			_drawPending = false;
			
			var a:Vertex = _line.a;			var b:Vertex = _line.b;
			
			switch (_line.type)
			{
				case LineType.LINE:
					drawLine(graphics, a, b);
					break;
				case LineType.RAY:
					drawRay(graphics, a, b);
					break;
				case LineType.SEGMENT:
					drawSegment(graphics, a, b);
					break;
			}
		}
		
		
		private function drawSegment(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			graphics.moveTo(a.x, a.y);			graphics.lineTo(b.x, b.y);
		}
		
		private function drawRay(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			graphics.moveTo(a.x, a.y);
			
			var i:Number = b.x - a.x;
			var j:Number = b.y - a.y;
			
			var length:Number = Math.sqrt(i * i + j * j);
			var multiplier:Number = _diagonal / length;
			
			i *= multiplier;			j *= multiplier;
			
			graphics.lineTo(b.x + i, b.y + j);
		}
		
		private function drawLine(graphics:Graphics, a:Vertex, b:Vertex):void
		{
			var i:Number = b.x - a.x;
			var j:Number = b.y - a.y;
			
			var length:Number = Math.sqrt(i * i + j * j);
			var multiplier:Number = _diagonal / length;
			
			i *= multiplier;
			j *= multiplier;
			
			graphics.moveTo(a.x - i, a.y - j);
			graphics.lineTo(b.x + i, b.y + j);
		}
	}
}
