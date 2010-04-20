package as3geometry.geom2D.ui 
{
	import as3geometry.geom2D.ui.generic.UIDrawer;
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	/**
	 * Draws a polygon on a Euclidean plane
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class PolygonDrawer extends UIDrawer
	{
		
		private var _polygon:Polygon;
		
		public function PolygonDrawer(context:AS3GeometryContext, polygon:Polygon, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_polygon = polygon);
			invalidate();
		}
		
		public function get polygon():Polygon
		{
			return _polygon;
		}
		
		public function set polygon(value:Polygon):void
		{
			if (_polygon == value)
				return;
			
			removeDefinien(_polygon);
			_polygon = value;
			addDefinien(_polygon);
			invalidate();
		}

		override protected function draw():void
		{
			var v:Vertex = polygon.getVertex(0);
			graphics.moveTo(v.x, v.y);
			
			var i:int = _polygon.countVertices;
			while (--i > -1)
			{
				v = _polygon.getVertex(i);
				graphics.lineTo(v.x, v.y);	
			}
		}

	}
}
