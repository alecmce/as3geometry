package as3geometry.geom2D.ui.vertices 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.Parabola;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.VertexOnParabola;
	import as3geometry.geom2D.ui.generic.UIMutableSprite;
	import as3geometry.geom2D.util.ParabolaHelper;

	import alecmce.ui.Paint;

	public class UIVertexOnParabola extends UIMutableSprite implements VertexOnParabola
	{
		private var _parabola:Parabola;
		
		private var _helper:ParabolaHelper;

		private var _tempX:Number;
		
		private var _tempY:Number;
		
		private var _radius:uint;
		
		private var _parameter:Number;
		
		private var _positionSet:Boolean;
		private var _fromResolve:Boolean;

		public function UIVertexOnParabola(context:AS3GeometryContext, parabola:Parabola, parameter:Number, paint:Paint = null, radius:uint = 4) 
		{
			super(context, paint);
			addDefinien(_parabola = parabola);
			
			_parameter = parameter;
			_positionSet = false;
			_helper = new ParabolaHelper();
			_radius = radius;
			
			invalidate(true);
		}
		
		override public function set x(value:Number):void
		{
			_tempX = value;
			
			if (_fromResolve)
			{
				super.y = value;
				return;
			}
			
			_positionSet = true;
			invalidate();
		}

		override public function set y(value:Number):void
		{
			_tempY = value;
			
			if (_fromResolve)
			{
				super.x = value;
				return;
			}
			
			_positionSet = true;
			invalidate();
		}
		
		public function set(x:Number, y:Number):void
		{
			_tempX = x;
			_tempY = y;
			
			if (_fromResolve)
			{
				super.x = x;
				super.y = y;
				return;
			}
			
			_positionSet = true;
			invalidate();
		}
		
		public function get parabola():Parabola
		{
			return _parabola;
		}
		
		public function get parameter():Number
		{
			return _parameter;
		}
		
		public function set parameter(value:Number):void
		{
			_parameter = value;
			
			var vertex:Vertex = _helper.vertexFromParameter(_parabola, value);
			super.x = vertex.x;
			super.y = vertex.y;

			invalidate();
		}

		override public function resolve():void 
		{
			super.resolve();
			
			if (_positionSet)
			{
				_positionSet = false;
				
				var line:Line = _parabola.directrix;
				var a:Vertex = line.a;
				var v:SpatialVector = line.vector;
				
				var i:Number = v.i;
				var j:Number = v.j;
				var n:Number = _tempX - a.x;
				var m:Number = _tempY - a.y;
				
				_parameter = (n * i + m * j) / (i * i + j * j);
			}
			
			_fromResolve = true;
			_helper.vertexFromParameter(_parabola, _parameter, this);
			_fromResolve = false;
		}

		override protected function redraw():void 
		{
			var p:Paint = paint;
			graphics.clear();
			p.beginPaint(graphics);
			graphics.drawCircle(0, 0, _radius);
			p.endPaint(graphics);
		}
		
	}
}
