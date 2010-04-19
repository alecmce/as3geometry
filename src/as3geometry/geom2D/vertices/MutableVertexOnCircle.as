package as3geometry.geom2D.vertices 
{
	import alecmce.invalidation.Mutable;

	import as3geometry.abstract.AbstractMutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.VertexOnCircle;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableVertexOnCircle extends AbstractMutable implements VertexOnCircle
	{

		private var _circle:Circle;
		
		private var _angle:Number;
		
		private var _x:Number;		private var _y:Number;

		public function MutableVertexOnCircle(circle:Circle, angle:Number)
		{
			addDefinien(_circle = circle);
			_angle = angle;
		}
		
		public function get circle():Circle
		{
			return _circle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(value:Number):void
		{
			if (_angle == value)
				return;
			
			_angle = value;
			update();
			_changed.dispatch(this);
		}

		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			update();
			super.onDefinienChanged(mutable);
		}

		private function update():void
		{
			var radius:Number = _circle.radius;
			
			_x = radius * Math.cos(_angle);			_y = radius * Math.sin(_angle);
		}
	}
}
