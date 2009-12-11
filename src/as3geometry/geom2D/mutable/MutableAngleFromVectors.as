package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.mutable.abstract.AbstractMutable;
	import as3geometry.geom2D.Angle;
	import as3geometry.geom2D.SpatialVector;
	import as3geometry.geom2D.util.AngleHelper;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutableAngleFromVectors extends AbstractMutable implements Angle
	{
		private var _helper:AngleHelper;
		
		private var _a:SpatialVector;		
		private var _b:SpatialVector;
		
		private var _radians:Number;
		
		private var _degrees:Number;
		
		public function MutableAngleFromVectors(a:SpatialVector, b:SpatialVector)
		{
			super();
			
			addDefinien(_a = a);			addDefinien(_b = b);
			
			_helper = new AngleHelper();
			recalculate();
		}
		
		public function get radians():Number
		{
			return _radians;
		}
		
		public function get degrees():Number
		{
			return _degrees;
		}
		
		public function get a():SpatialVector
		{
			return _a;
		}
		
		public function set a(a:SpatialVector):void
		{
			if (_a == a)
				return;
			
			removeDefinien(_a);
			_a = a;
			addDefinien(_a);
			
			_changed.dispatch(this);
		}
		
		public function get b():SpatialVector
		{
			return _b;
		}
		
		public function set b(b:SpatialVector):void
		{
			if (_b == b)
				return;
			
			removeDefinien(_b);
			_b = b;
			addDefinien(_b);
			
			_changed.dispatch(this);
		}

		override protected function onDefinienChanged(mutable:Mutable):void
		{
			recalculate();
			super.onDefinienChanged(mutable);
		}
		
		
		private function recalculate():void
		{
			_radians = _helper.directedAngleFromVectors(_a.i, _a.j, _b.i, _b.j);
			_degrees = _helper.toDegrees(_radians);
		}
	}
}
