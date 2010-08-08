package as3geometry.geom2D.ui 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.generic.UIDrawer;

	import ui.Paint;

	import flash.events.Event;

	public class ParabolaDrawer extends UIDrawer
	{
		private var _parabola:Parabola;
		
		private var _diagonal:Number;
		
		private var _drawPending:Boolean;
		
		public function ParabolaDrawer(context:AS3GeometryContext, parabola:Parabola, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_parabola = parabola);
			
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

		public function get parabola():Parabola
		{
			return _parabola;
		}
		
		public function set parabola(value:Parabola):void
		{
			if (_parabola == value)
				return;
			
			removeDefinien(_parabola);
			addDefinien(_parabola = value);
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
			
			var n:Number;
			var line:Line = _parabola.directrix;
			
			var a:Vertex = line.a;
			var b:Vertex = line.b;
			
			// a point on the parabola's directrix a
			var ax:Number = a.x;
			var ay:Number = a.y;
			
			// a point on the parabola's directrix b
			var bx:Number = b.x;
			var by:Number = b.y;
			
			// the vector ab
			var ab_x:Number = bx - ax;
			var ab_y:Number = by - ay;
			
			var type:LineType = _parabola.directrix.type;
			
			if (type == LineType.LINE || type == LineType.RAY)
			{
				var scalar:Number = _diagonal / Math.sqrt(ab_x * ab_x + ab_y * ab_y); 
				
				var xx:Number = ax + ab_x * scalar;
				var yy:Number = ay + ab_y * scalar;
				
				if (type == LineType.LINE)
				{
					ax = bx - ab_x * scalar;
					ay = by - ab_y * scalar;
				}
				
				bx = xx;
				by = yy;
				
				ab_x = bx - ax;
				ab_y = by - ay;
			}
			
			// the parabola focus
			var c:Vertex = _parabola.focus;
			var cx:Number = c.x;
			var cy:Number = c.y;
			
			// the vector ac
			var ac_x:Number = cx - ax;
			var ac_y:Number = cy - ay;
			
			// the vector bc
			var bc_x:Number = cx - bx;
			var bc_y:Number = cy - by;
			
			// calculate d, perpendicular to ab, equidistant from a and c
			n = (ac_x * ac_x + ac_y * ac_y) / (2 * (ab_x * ac_y - ab_y * ac_x));
			var dx:Number = ax - ab_y * n;
			var dy:Number = ay + ab_x * n;
			
			// calculate e, perpendicular to ab, equidistant from b and c
			n = (bc_x * bc_x + bc_y * bc_y) / (2 * (ab_x * bc_y - ab_y * bc_x));
			var ex:Number = bx - ab_y * n;
			var ey:Number = by + ab_x * n;
			
			// calculate f, midway point of ac
			var fx:Number = (ax + cx) * .5;			var fy:Number = (ay + cy) * .5;
			
			// calculate g, midway point of bc
			var gx:Number = (bx + cx) * .5;
			var gy:Number = (by + cy) * .5;
			
			// calculate h, the bezier curve control point
			n = ((gx - fx) * ac_x + (gy - fy) * ac_y) / (bc_y * ac_x - bc_x * ac_y);
			var hx:Number = gx - bc_y * n;
			var hy:Number = gy + bc_x * n;
			
			graphics.moveTo(dx, dy);			graphics.curveTo(hx, hy, ex, ey);		}
		
		
		
	}
}
