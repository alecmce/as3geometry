package com.alecmce.maths.geom.line
{
	import org.osflash.signals.Signal;

	import flash.geom.Point;

	public class QuadraticBezier
	{
		private static const TWO_PI:Number = 2 * Math.PI;

		private var _sX:Number;		private var _sY:Number;

		private var _fX:Number;		private var _fY:Number;

		private var _cX:Number;		private var _cY:Number;

		private var _scX:Number;
		private var _scY:Number;

		private var _cfX:Number;
		private var _cfY:Number;

		private var _changed:Signal;

		public function QuadraticBezier(sX:Number, sY:Number, fX:Number, fY:Number, cX:Number, cY:Number)
		{
			_sX = sX;
			_sY = sY;
			_fX = fX;
			_fY = fY;
			_cX = cX;
			_cY = cY;

			_scX = _cX - _sX;			_scY = _cY - _sY;			_cfX = _fX - _cX;			_cfY = _fY - _cY;

			_changed = new Signal();
		}

		public function position(value:Number):Point
		{
			var s2cX:Number = _sX + _scX * value;
			var s2cY:Number = _sY + _scY * value;
			var c2fX:Number = _cX + _cfX * value;
			var c2fY:Number = _cY + _cfY * value;

			return new Point(s2cX + (c2fX - s2cX) * value, s2cY + (c2fY - s2cY) * value);
		}

		public function cache(positions:Vector.<Number>):Vector.<Point>
		{
			var count:uint = positions.length;
			var result:Vector.<Point> = new Vector.<Point>(count, true);

			for (var i:int = 0;i < count;i++)
				result[i] = position(positions[i]);

			return result;
		}

		public function cacheVectors(positions:Vector.<Number>):Vector.<Point>
		{
			var count:uint = positions.length;
			var result:Vector.<Point> = new Vector.<Point>(count, true);
			var p:Point = position(positions[0]);

			for (var i:int = 1; i < count; i++)
			{
				var q:Point = position(positions[i]);
				var v:Point = new Point(q.x - p.x, q.y - p.y);
				result[i] = v;

				p = q;
			}

			return result;
		}

		public function variation(s:Number, f:Number, c:Number):QuadraticBezier
		{
			var angle:Number = Math.random() * TWO_PI;

			var sX:Number = _sX + Math.cos(angle) * s;			var sY:Number = _sY + Math.sin(angle) * s;

			var fX:Number = _fX + Math.cos(angle) * f;
			var fY:Number = _fY + Math.sin(angle) * f;

			var cX:Number = _cX + Math.cos(angle) * c;
			var cY:Number = _cY + Math.sin(angle) * c;

			return new QuadraticBezier(sX, sY, fX, fY, cX, cY);
		}

		public function setStart(x:Number, y:Number):void
		{
			_sX = x;
			_sY = y;

			_scX = _cX - _sX;
			_scY = _cY - _sY;

			_changed.dispatch();
		}

		public function setControl(x:Number, y:Number):void
		{
			_cX = x;
			_cY = y;

			_scX = _cX - _sX;
			_scY = _cY - _sY;
			_cfX = _fX - _cX;
			_cfY = _fY - _cY;

			_changed.dispatch();
		}

		public function setFinish(x:Number, y:Number):void
		{
			_fX = x;
			_fY = y;

			_cfX = _fX - _cX;
			_cfY = _fY - _cY;

			_changed.dispatch();
		}

		public function get sX():Number
		{
			return _sX;
		}

		public function get sY():Number
		{
			return _sY;
		}

		public function get fX():Number
		{
			return _fX;
		}

		public function get fY():Number
		{
			return _fY;
		}

		public function get cX():Number
		{
			return _cX;
		}

		public function get cY():Number
		{
			return _cY;
		}

		public function get changed():Signal
		{
			return _changed;
		}
	}
}