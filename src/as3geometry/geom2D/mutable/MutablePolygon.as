package as3geometry.geom2D.mutable 
{
	import as3geometry.geom2D.Polygon;
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.mutable.Mutable;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * Defines a polygon on a Cartesian plane by a list of vertices
	 *
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class MutablePolygon implements Polygon, Mutable
	{
		
		/*********************************************************************/
		// Member Variables
		/*********************************************************************/
		
		
		/** a vertex of the line */
		private var _vertices:Vector.<Vertex>;

		private var _changed:ISignal;

		
		/*********************************************************************/
		// Public Methods
		/*********************************************************************/

		
		/**
		 * Class Constructor
		 * 
		 * @param vertices The array of vertices that defines the polygon
		 */
		public function MutablePolygon(vertices:Vector.<Vertex>)
		{
			_vertices = vertices;
			_changed = new Signal(this, Mutable);
			
			var i:int = vertices.length;
			while (--i > -1)
			{
				var v:Vertex = vertices[i];
				if (v is Mutable)
					Mutable(v).changed.add(onDefinienChanged);
			}
		}
		
		private function onDefinienChanged(mutable:Mutable):void
		{
			_changed.dispatch(mutable);
		}
				
		/**
		 * @return The number of vertices in the polygon
		 */
		public function get count():int
		{
			return _vertices.length;
		}
		
		/**
		 * retrieve the vertex at a given index
		 * 
		 * @param index The index of the vertex to be retrieved
		 * 
		 * @return The vertex at the corresponding index
		 */
		public function get(index:int):Vertex
		{
			return _vertices[index];
		}
		
		public function get changed():ISignal
		{
			return _changed;
		}
	}
}
