package as3geometry.geom2D.intersection
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.VertexOnCircle;

	/**
	 *
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionOfCircleAndLine extends Mutable
	{
		private var _circle:Circle;
		private var _line:Line;

		private var _first:CircleAndLineIntersectionVertex;
		private var _second:CircleAndLineIntersectionVertex;

		public function IntersectionOfCircleAndLine(context:AS3GeometryContext, circle:Circle, line:Line)
		{
			super(context);

			_circle = circle;
			addDefinien(_circle);

			_line = line;
			addDefinien(_line);

			_first = new CircleAndLineIntersectionVertex(context, this);			_second = new CircleAndLineIntersectionVertex(context, this);

			invalidate(true);
		}

		public function get circle():Circle
		{
			return _circle;
		}

		public function set circle(circle:Circle):void
		{
			if (_circle == circle)
				return;

			removeDefinien(_circle);
			_circle = circle;
			addDefinien(_circle);
			invalidate();
		}

		public function get line():Line
		{
			return _line;
		}

		public function set line(line:Line):void
		{
			if (_line == line)
				return;

			removeDefinien(_line);
			_line = line;
			addDefinien(_line);
			invalidate();
		}

		public function get first():VertexOnCircle
		{
			return _first;
		}

		public function get second():VertexOnCircle
		{
			return _second;
		}

		override public function resolve():void
		{
			var fx:Number = Number.NaN;			var fy:Number = Number.NaN;			var sx:Number = Number.NaN;			var sy:Number = Number.NaN;

			if (_circle && _line)
			{
				var cx:Number = _circle.center.x;				var cy:Number = _circle.center.y;
				var r:Number = _circle.radius;
				var x:Number = _line.a.x - cx;				var y:Number = _line.a.y - cy;
				var i:Number = _line.b.x - _line.a.x;				var j:Number = _line.b.y - _line.a.y;

				// you can derive a quadratic of the form An^2 + Bn + C = 0
				var A:Number = i * i + j * j;
				var B:Number = 2 * (x * i + y * j);
				var C:Number = x * x + y * y - r * r;

				var n:Number;

				// checking the discriminant for number of solutions
				var discriminant:Number = B * B - 4 * A * C;
				if (discriminant == 0)
				{
					n = -B / (2 * A);

					if (_line.type.isValidPositionMultiplier(n))
					{
						fx = cx + x + i * n;
						fy = cy + y + j * n;
					}
				}
				else if (discriminant > 0)
				{
					discriminant = Math.sqrt(discriminant);

					cx += x;
					cy += y;

					n = (-B + discriminant) / (2 * A);
					var isFirstValueValid:Boolean = _line.type.isValidPositionMultiplier(n);
					if (isFirstValueValid)
					{
						fx = cx + i * n;
						fy = cy + j * n;
					}

					n = (-B - discriminant) / (2 * A);
					if (_line.type.isValidPositionMultiplier(n))
					{
						if (isFirstValueValid)
						{
							sx = cx + i * n;							sy = cy + j * n;
						}
						else
						{
							fx = cx + i * n;
							fy = cy + j * n;
						}
					}
				}
			}

			_first.update(_circle, fx, fy);			_second.update(_circle, sx, sy);
		}
	}
}
