package as3geometry.geom2D.vertices
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnCircle;
	
	/**
	 * Creates a vertex that lies on a circle by projecting a vertex onto the surface
	 * of the circle
	 * 
	 * (c) 2010 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class ProjectVertexToCircle extends Mutable implements VertexOnCircle
	{
		private var _circle:Circle;
		private var _vertex:Vertex;
		
		private var _x:Number;
		private var _y:Number;
		private var _angle:Number;
		
		public function ProjectVertexToCircle(context:AS3GeometryContext, circle:Circle, vertex:Vertex)
		{
			super(context);
			
			addDefinien(_circle = circle);			addDefinien(_vertex = vertex);
			
			invalidate(true);
		}

		public function get circle():Circle
		{
			return _circle;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function get x():Number
		{
			return _x;
		}

		public function get y():Number
		{
			return _y;
		}
		
		override public function resolve():void
		{
			var dx:Number = _vertex.x - _circle.center.x;
			var dy:Number = _vertex.y - _circle.center.y;
			_angle = Math.atan2(dy, dx);
			
			_x = Math.cos(_angle) * _circle.radius;			_y = Math.sin(_angle) * _circle.radius;
		}

		
	}
}
