package as3geometry.geom2D.intersection
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.LineType;
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.line.ImmutableLine;
	import as3geometry.geom2D.line.IntersectionOfTwoLinesVertex;
	import as3geometry.geom2D.vertices.IndependentVertex;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionsOfLineAndPolygon extends Mutable
	{

		private var _polygon:Polygon;
		private var _line:Line;

		private var _potential:Array;
		private var _actual:Array;

		public function IntersectionsOfLineAndPolygon(context:AS3GeometryContext, polygon:Polygon, line:Line)
		{
			super(context);

			_polygon = polygon;
			addDefinien(_polygon);

			_line = line;
			addDefinien(_line);

			_potential = calculateVertices();
			_actual = generateActuals();
			invalidate(true);
		}

		public function get potentialIntersections():Array
		{
			return _potential;
		}

		public function get actualIntersections():Array
		{
			return _actual;
		}

		override public function resolve():void
		{
			super.resolve();

			var sorted:Array = _potential.sort(sortByMultipliers);

			var len:int = _potential.length;
			var nullify:Boolean = false;
			for (var i:int = 0; i < len; i++)
			{
				var a:IndependentVertex = _actual[i];

				p = sorted[i];
				if (!nullify)
				{
					var p:IntersectionOfTwoLinesVertex = sorted[i];
					nullify = isNaN(p.x);
				}

				if (nullify)
					a.set(Number.NaN, Number.NaN);
				else
					a.set(p.x, p.y);
			}
		}

		private function calculateVertices():Array
		{
			var count:int = _polygon.countVertices;
			var vertices:Array = [];

			var b:Vertex = _polygon.getVertex(count - 1);
			for (var i:int = 0; i < count; i++)
			{
				var a:Vertex = _polygon.getVertex(i);
				var edge:ImmutableLine = new ImmutableLine(a, b, LineType.SEGMENT);
				var vertex:IntersectionOfTwoLinesVertex = new IntersectionOfTwoLinesVertex(context, edge, _line);
				b = a;

				vertices[i] = vertex;
			}

			return vertices;
		}

		private function generateActuals():Array
		{
			var n:int = _potential.length;
			var actuals:Array = [];

			while (--n > -1)
				actuals[n] = new IndependentVertex(context, Number.NaN, Number.NaN);

			return actuals;
		}

		private function sortByMultipliers(a:IntersectionOfTwoLinesVertex, b:IntersectionOfTwoLinesVertex):int
		{
			var aN:Number = a.bMultiplier;			var bN:Number = b.bMultiplier;

			var isAInvalid:Boolean = isNaN(aN);
			var isBInvalid:Boolean = isNaN(bN);

			if (isAInvalid && isBInvalid)
				return 0;
			else if (isAInvalid)
				return 1;
			else if (isBInvalid)
				return -1;
			if (aN < bN)
				return -1;
			else if (aN > bN)
				return 1;

			return 0;
		}

	}
}
