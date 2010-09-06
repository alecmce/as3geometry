package as3geometry.geom2D.ui 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.generic.UIDrawer;

	import alecmce.ui.Paint;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class VertexDrawer extends UIDrawer
	{
		private var _vertex:Vertex;
		
		private var _radius:uint;
		
		public function VertexDrawer(context:AS3GeometryContext, vertex:Vertex, radius:uint = 4, paint:Paint = null)
		{
			super(context, paint);
			_radius = radius;
			addDefinien(_vertex = vertex);
			invalidate();
		}
		
		public function get vertex():Vertex
		{
			return _vertex;
		}
		
		public function set vertex(value:Vertex):void
		{
			if (_vertex == value)
				return;
			
			removeDefinien(_vertex);
			_vertex = value;
			addDefinien(_vertex);
			invalidate();
		}
		
		public function get radius():uint
		{
			return _radius;
		}
		
		public function set radius(value:uint):void
		{
			if (_radius == value)
				return;
			
			_radius = value;
			invalidate();
		}

		override protected function draw():void
		{
			if (isNaN(_vertex.x) || isNaN(_vertex.y))
				return;
			
			graphics.drawCircle(_vertex.x, _vertex.y, _radius);
			var p:Paint = paint;
			p.beginPaint(graphics);
			graphics.drawCircle(_vertex.x, _vertex.y, _radius);
			p.endPaint(graphics);
		}
	}
}
