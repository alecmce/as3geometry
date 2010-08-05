package as3geometry.geom2D.parabola 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.Vertex;

	public class MutableParabola extends Mutable implements Parabola
	{
		private var _focus:Vertex;
		private var _directrix:Line;

		public function MutableParabola(context:AS3GeometryContext, focus:Vertex, directrix:Line)
		{
			super(context);
			addDefinien(_focus = focus);
			addDefinien(_directrix = directrix);
			invalidate(true);
		}
		
		public function getVertex(n:Number):Vertex
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		public function get focus():Vertex
		{
			return _focus;
		}
		
		public function get directrix():Line
		{
			return _directrix;
		}
	}
}
