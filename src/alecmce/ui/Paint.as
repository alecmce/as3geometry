package alecmce.ui 
{
	import flash.display.Graphics;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Paint 
	{
		
		function beginPaint(graphics:Graphics):void;
		
		function endPaint(graphics:Graphics):void;
		
	}
}
