package alecmce.data.graph.algorithms 
{
	import alecmce.data.graph.DirectedGraph;
	import alecmce.data.graph.GraphJoin;

	import flash.utils.Dictionary;

	/**
	 * Discovers the shortest-path from an initial node to all other nodes within
	 * a graph using the Dijkstra Algorithm.
	 * 
	 * @see http://en.wikipedia.org/wiki/Dijkstra's_algorithm
	 */
	public class Dijkstra 
	{
		private var _costs:Dictionary;
		private var _visited:Dictionary;
		private var _previous:Dictionary;
		private var _graph:DirectedGraph;
		
		private var _isReset:Boolean;

		public function Dijkstra() 
		{
			reset();
		}
		
		public function reset():void
		{
			if (_isReset)
				return;
			
			_costs = new Dictionary();
			_visited = new Dictionary();
			_previous = new Dictionary();			_graph = null;
			_isReset = true;
		}
		
		public function apply(graph:DirectedGraph, initial:Object):void
		{
			if (!_isReset)
				reset();
			
			_graph = graph;
			setInitialCosts(initial);
			findCosts(initial);
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
			var len:uint = nodes.length;
			
			for (var i:uint = 0; i < len; i++)
				_costs[nodes[i]] = Number.POSITIVE_INFINITY;
			
			_costs[initial] = 0;
		}

		private function findCosts(current:Object):void 
		{
			var nearestNeighbour:Object;
			var lowestCostToNeighbour:Number;
			
			var joins:Vector.<GraphJoin> = _graph.getJoins(current);
			var len:uint = joins.length;
			
			for (var i:uint = 0; i < len; i++)
			{
				var join:GraphJoin = joins[i];
				var target:Object = join.destination;
				var cost:Number = join.cost;
				if (cost < 0)
					throw new Error("Dijkstra's Algorithm functions only if the join costs are positive. Use Bellman-Ford for graphs with negative costs");
				
				if (_visited[target])
					continue;
					
				cost += _costs[current];
				if (_costs[target] != null && cost < _costs[target])
					_costs[target] = cost;
				
				if (nearestNeighbour == null || cost < lowestCostToNeighbour)
				{
					lowestCostToNeighbour = cost;
					nearestNeighbour = target;
					_previous[target] = current;
				}
			}
			
			_visited[current] = true;
			if (nearestNeighbour)
				findCosts(nearestNeighbour);
		}
	}
}
