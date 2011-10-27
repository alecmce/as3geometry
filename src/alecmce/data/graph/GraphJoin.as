package alecmce.data.graph
{

	/**
	 * @author amceachran
	 */
	public class GraphJoin
	{
		private var _source:Object;		private var _destination:Object;
		private var _cost:Number;

		public function GraphJoin(source:Object, destination:Object, cost:Number)
		{
			_source = source;
			_destination = destination;
			_cost = cost;
		}

		public function get source():Object
		{
			return _source;
		}

		public function get destination():Object
		{
			return _destination;
		}

		public function get cost():Number
		{
			return _cost;
		}
	}
}
