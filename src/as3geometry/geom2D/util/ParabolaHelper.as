package as3geometry.geom2D.util 
{

	public class ParabolaHelper 
	{
		
		public function yOnVerticalParabola(x:Number, directrixY:Number):Number
		{
			return (x * x) / (4 * -directrixY);
		}
		
		public function xOnVerticalParabola(y:Number, directrixY:Number):Number
		{
			var value:Number = 4 * y * -directrixY;
			if (value < 0)
				return Number.NaN;
			
			return Math.sqrt(value);
		}
		
	}
}
