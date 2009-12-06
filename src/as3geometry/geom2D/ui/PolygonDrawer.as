package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	import ui.Paint;

	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonDrawer extends GeneralDrawer
	{
		
		private var _polygon:Polygon;
		
		public function PolygonDrawer(polygon:Polygon, paint:Paint = null)
		{
			_polygon = polygon;
			if (_polygon is Mutable)
				Mutable(_polygon).changed.add(onDefinienChanged);
			
			super(paint);
		}
		
		public function get polygon():Polygon
		{
			return _polygon;
		}
		
		public function set polygon(value:Polygon):void
		{
			if (_polygon == value)
				return;
			
			if (_polygon is Mutable)
				Mutable(_polygon).changed.remove(onDefinienChanged);
			
			_polygon = value;
			
			if (_polygon is Mutable)
				Mutable(_polygon).changed.add(onDefinienChanged);
				
			addEventListener(Event.ENTER_FRAME, redraw);
		}

		override protected function draw():void
		{
			var v:Vertex = polygon.getVertex(0);
			graphics.moveTo(v.x, v.y);
			
			var i:int = _polygon.count;
			while (--i > -1)
			{
				v = _polygon.getVertex(i);
				graphics.lineTo(v.x, v.y);	
			}
		}

	}
}
