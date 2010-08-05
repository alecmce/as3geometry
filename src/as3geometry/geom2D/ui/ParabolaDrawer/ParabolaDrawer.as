package as3geometry.geom2D.ui.ParabolaDrawer 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.generic.UIDrawer;
	import as3geometry.geom2D.util.ParabolaHelper;

	import ui.Paint;

	import flash.events.Event;

	public class ParabolaDrawer extends UIDrawer
	{
		
		private var _parabola:Parabola;
		
		private var _diagonal:Number;
		
		private var _drawPending:Boolean;
		
		private var _helper:ParabolaHelper;
		
		public function ParabolaDrawer(context:AS3GeometryContext, parabola:Parabola, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_parabola = parabola);
			
			_drawPending = false;
			_helper = new ParabolaHelper();
			
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
			
			var line:Line = _parabola.directrix;
			
			// the line registration point a
			var a:Vertex = line.a;
			var ax:Number = a.x;
			var ay:Number = a.y;
			
			// the line registraion point b
			var b:Vertex = line.b;
			var bx:Number = b.x;
			var by:Number = b.y;
			
			// the parabola focus
			var c:Vertex = _parabola.focus;
			var cx:Number = c.x;
			var cy:Number = c.y;
			
			// the vector from a to be that defines the direction of the line
			var bx_ax:Number = bx - ax;
			var by_ay:Number = by - ay;
			var abSqrd:Number = (bx_ax * bx_ax + by_ay * by_ay);
			var abInv:Number = 1 / Math.sqrt(abSqrd);
			
			// we want to get the vector from c to the point closest to it on the
			// line ab. Call that point d. We know that the vector cd is perpendicular
			// to the vector ab. delta is the amount we have to scale the vector ab to
			// get the right length for cd.
			var cx_ax:Number = cx - ax;
			var cy_ay:Number = cy - ay;
			var delta:Number = (by_ay * cx_ax - bx_ax * cy_ay) / abSqrd;
			
			// the vector cd defined
			var dx_cx:Number = -by_ay * delta;
			var dy_cy:Number = bx_ax * delta;
			
			// the point d defined, along with the length of cd. This is the 'focal
			// parameter' of the parabola, which is an important value.
			var dx:Number = cx + dx_cx;
			var dy:Number = cy + dy_cy;
			var cd:Number = Math.sqrt(dx_cx * dx_cx + dy_cy * dy_cy);
			var cdInv:Number = 1 / cd;
			var cdHalf:Number = cd * 0.5;
			
			// the point e defined, which lies between the focus and directrix
			// where the parametric value is 0 (the closest point to both the focus
			// and directrix)
			var ex:Number = cx + dx_cx * 0.5;
			var ey:Number = cy + dy_cy * 0.5;
			
			// the strategy now is to use the parametric form of the parabola equation
			// to work out where if you project a and b onto the parabola, they would
			// be positioned. To do this I need to tranlsate the coordinate system of
			// the parameteric equations into the real coordinate sytem...
			
			// (mx,my) is a unit vector along the line ab, which will be my x-vector.
			// my y-vector will be it's perpendicular: (-my,mx)
			var mx:Number = bx_ax * abInv;
			var my:Number = by_ay * abInv;

			// work out how far a is away from d anormx, which in the normal parametric
			// form is my x coordinate. This lets me derive the parameter
			// T which lets me derive the normal parametric coordinate anormy. 
			var dx_ax:Number = dx - ax;
			var dy_ay:Number = dy - ay;
			var anormx:Number = -Math.sqrt(dx_ax * dx_ax + dy_ay * dy_ay);
			var aT:Number = anormx * cdInv;
			var anormy:Number = cdHalf * aT * aT;
						
			// do the same thing as just described for b as well
			var dx_bx:Number = dx - bx;
			var dy_by:Number = dy - by;
			var bnormx:Number = Math.sqrt(dx_bx * dx_bx + dy_by * dy_by);
			var bT:Number = bnormx * cdInv;
			var bnormy:Number = cdHalf * bT * bT;
			
			// now convert that into real-world coordinates by translating (dx,dy)
			// along the axes (mx,my) and (-my,mx) by the magnitudes [amx,amy] and
			// [bmx,bmy].
			var fx:Number = ex + anormx * mx - anormy * my;
			var fy:Number = ey + anormx * my + anormy * mx;
			var tx:Number = ex + bnormx * mx - bnormy * my;
			var ty:Number = ey + bnormx * my + bnormy * mx;
			
			graphics.moveTo(fx, fy);
			graphics.curveTo(dx, dy, tx, ty);
			
		}
		
		
		
	}
}
