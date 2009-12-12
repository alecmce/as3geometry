package as3geometry.geom2D.intersection 
{
	import as3geometry.geom2D.Circle;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.mutable.abstract.AbstractMutable;
	import as3geometry.geom2D.mutable.Mutable;
	import as3geometry.geom2D.mutable.MutableVertex;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class IntersectionVerticesOfCircleAndLine extends AbstractMutable implements Mutable
	{
		private var _circle:Circle;
		private var _line:Line;
		
		private var _first:MutableVertex;
		private var _second:MutableVertex;

		public function IntersectionVerticesOfCircleAndLine(circle:Circle, line:Line)
		{
			super();
			
			_circle = circle;
			addDefinien(_circle);
			
			_line = line;
			addDefinien(_line);
			
			_first = new MutableVertex(Number.NaN, Number.NaN);			_second = new MutableVertex(Number.NaN, Number.NaN);
			
			update();
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
			
			_changed.dispatch(this);
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
			
			_changed.dispatch(this);
		}
		
		public function get first():MutableVertex
		{
			return _first;
		}
		
		public function get second():MutableVertex
		{
			return _second;
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			update();
			
			_first.changed.dispatch(mutable);			_second.changed.dispatch(mutable);
			super.onDefinienChanged(this);
		}
		
		private function update():void
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
			
			_first.set(fx, fy);			_second.set(sx, sy);
		}
	}
}
