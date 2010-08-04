package as3geometry.geom2D.ui 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.ui.generic.UIDrawer;

	import ui.Paint;

	/**
	 * Draws a circle
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class CircleDrawer extends UIDrawer
	{
		private var _circle:Circle;
		
		public function CircleDrawer(context:AS3GeometryContext, circle:Circle, paint:Paint = null)
		{
			super(context, paint);
			addDefinien(_circle = circle);
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function set circle(value:Circle):void
		{
			if (_circle == value)
				return;
			
			removeDefinien(_circle);
			_circle = value;
			addDefinien(_circle);
			invalidate();
		}

		override protected function draw():void
		{
			trace("[RESOLVE] CircleDrawer");
			
			try
			{
				var c:Vertex = _circle.center;
				graphics.drawCircle(c.x, c.y, _circle.radius);
			}
			catch (error:Error)
			{
				// do nothing
			}
		}

	}
}
