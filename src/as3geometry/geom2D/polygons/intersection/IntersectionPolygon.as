package as3geometry.geom2D.polygons.intersection 
{
	import as3geometry.AdditiveCollection;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.polygons.MutablePolygon;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class IntersectionPolygon extends MutablePolygon implements AdditiveCollection
	{

		private var _added:ISignal;
		private var _removed:ISignal;

		public function IntersectionPolygon(vertices:Array)
		{
			_added = new Signal(this, Vertex);			_removed = new Signal(this, Vertex);
			
			super(vertices);
		}
		
		
		public function removeVertex(vertex:Vertex):void
		{
			var i:int = _vertices.indexOf(vertex);
			if (i == -1)
				return;
				
			_vertices.splice(i, 1);
			_removed.dispatch(vertex);
		}
		
		public function get added():ISignal
		{
			return _added;
		}
		
		public function get removed():ISignal
		{
			return _removed;
		}
	}
}
