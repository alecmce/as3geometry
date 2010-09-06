package as3geometry.geom2D.ui 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.CircleSector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.generic.UIDrawer;
	import as3geometry.geom2D.util.AngleHelper;

	import alecmce.ui.Paint;
	import alecmce.ui.util.UIArcHelper;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleSectorDrawer extends UIDrawer
	{
		private var angles:AngleHelper;
		
		private var helper:UIArcHelper;
		
		private var _sector:CircleSector;
		
		public function CircleSectorDrawer(context:AS3GeometryContext, sector:CircleSector, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_sector = sector);
			angles = new AngleHelper();
			helper = new UIArcHelper();
			invalidate();
		}
		
		public function get sector():CircleSector
		{
			return _sector;
		}
		
		public function set sector(value:CircleSector):void
		{
			if (_sector == value)
				return;
			
			removeDefinien(_sector);
			_sector = value;
			addDefinien(_sector);
			invalidate();
		}

		override protected function draw():void
		{
			var circle:Circle = _sector.from.circle;
			var c:Vertex = circle.center;
			var radius:Number = circle.radius;
			var angle:Number = _sector.from.angle;			var sweep:Number = _sector.angle;
			
			if (isNaN(c.x) || isNaN(c.y) || isNaN(angle) || isNaN(radius) || isNaN(sweep))
				return;
			
			var x:Number = c.x;
			var y:Number = c.y;
			
			var start:Vertex = helper.arcInitialPosition(x, y, radius, angle);
			graphics.moveTo(x, y);
			graphics.lineTo(start.x, start.y);
			helper.drawArc(graphics, c.x, c.y, radius, angle, sweep);
			graphics.lineTo(x, y);
		}

	}
}
