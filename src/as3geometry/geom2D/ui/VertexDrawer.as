package as3geometry.geom2D.ui 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.geom2D.Vertex;

	import ui.Paint;

	import flash.events.Event;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class VertexDrawer extends GeneralDrawer
	{
		
		private var _vertex:Vertex;
		
		private var _radius:uint;
		
		public function VertexDrawer(vertex:Vertex, radius:uint = 4, paint:Paint = null)
		{
			_radius = radius;
			
			_vertex = vertex;
			if (_vertex is Mutable)
				Mutable(_vertex).changed.add(onDefinienChanged);
				
			super(paint);
		}
		
		public function get vertex():Vertex
		{
			return _vertex;
		}
		
		public function set vertex(value:Vertex):void
		{
			if (_vertex == value)
				return;
			
			if (_vertex is Mutable)
				Mutable(_vertex).changed.remove(onDefinienChanged);
			
			_vertex = value;
			
			if (_vertex is Mutable)
				Mutable(_vertex).changed.add(onDefinienChanged);
			
			addEventListener(Event.ENTER_FRAME, redraw);
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
			
			addEventListener(Event.ENTER_FRAME, redraw);
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			super.onDefinienChanged(mutable);
		}

		override protected function draw():void
		{
			if (isNaN(_vertex.x) || isNaN(_vertex.y))
				return;
			
			graphics.drawCircle(_vertex.x, _vertex.y, _radius);
			var p:Paint = _paint ? _paint : DEFAULT_PAINT;
			p.beginPaint(graphics);
			graphics.drawCircle(_vertex.x, _vertex.y, _radius);
			p.endPaint(graphics);
		}
	}
}
