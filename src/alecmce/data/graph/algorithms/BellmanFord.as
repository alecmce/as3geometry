package alecmce.data.graph.algorithms
{
	import alecmce.data.graph.DirectedGraph;
	import alecmce.data.graph.GraphJoin;

	import flash.utils.Dictionary;

	/**
	 * Discovers the shortest-path from an initial node to all other nodes within
	 * a graph using the Bellman-Ford Algorithm
	 *
	 * TODO An efficiency improvement to Bellman-Ford exists, called Yen's
	 * improvement. This has not yet been implemented.
	 *
	 * @see http://en.wikipedia.org/wiki/Bellman-Ford_algorithm
	 */
	public class BellmanFord
	{

		private var _costs:Dictionary;
		private var _previous:Dictionary;
		private var _graph:DirectedGraph;

		private var _isReset:Boolean;

		public function BellmanFord()
		{
			reset();
		}

		public function reset():void
		{
			if (_isReset)
				return;

			_costs = new Dictionary();
			_previous = new Dictionary();
			_graph = null;
			_isReset = true;
		}

		public function apply(graph:DirectedGraph, initial:Object):void
		{
			if (!_isReset)
				reset();

			_graph = graph;
			setInitialCosts(initial);

			var len:uint = _graph.nodes.length;
			var joins:Vector.<GraphJoin> = _graph.joins;
			for (var i:int = 0; i < len; i++)
				findCosts(joins);

			_isReset = false;
		}

		public function getCost(node:Object):Number
		{
			return _costs[node];
		}

		public function getRoute(node:Object):Vector.<Object>
		{
			var nodes:Vector.<Object> = new Vector.<Object>();

			nodes[0] = node;

			while (_previous[node])
			{
				node = _previous[node];
				nodes.push(node);
			}

			return nodes.reverse();
		}

		public function get graph():DirectedGraph
		{
			return _graph;
		}

		private function setInitialCosts(initial:Object):void
		{
			var nodes:Vector.<Object> = _graph.nodes;

			for each (var node:Object in nodes)
				_costs[node] = Number.POSITIVE_INFINITY;

			_costs[initial] = 0;
		}

		private function findCosts(joins:Vector.<GraphJoin>):void
		{
			for each (var join:GraphJoin in joins)
			{
				var source:Object = join.source;
				var destination:Object = join.destination;

				var cost:Number = _costs[source] + join.cost;
				if (cost < _costs[destination])
				{
					_costs[destination] = cost;
					_previous[destination] = source;
				}
			}
		}

	}
}
