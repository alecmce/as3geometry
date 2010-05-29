package alecmce.data.graph 
{
	import flash.utils.Dictionary;

	public class Graph 
	{
		protected var _nodes:Vector.<Object>;
		protected var _joins:Vector.<GraphJoin>;
		protected var _joinMap:Dictionary;
		
		public function Graph() 
		{
			_nodes = new Vector.<Object>();
			_joins = new Vector.<GraphJoin>();
			_joinMap = new Dictionary();
		}
		
		public function getJoins(node:Object):Vector.<GraphJoin>
		{
			return _joinMap[node] ||= new Vector.<GraphJoin>();
		}
		
		public function get nodes():Vector.<Object>
		{
			return _nodes;
		}

		public function get joins():Vector.<GraphJoin>
		{
			return _joins;
		}
		
		public function joinNodes(a:Object, b:Object, cost:Number = 1):void 
		{
			registerNode(a);
			registerNode(b);
			
			var joinsA:Vector.<GraphJoin> = getJoins(a);
			var joinsB:Vector.<GraphJoin> = getJoins(b);
			var join:GraphJoin = new GraphJoin(a, b, cost);
			
			joinsA.push(join);			joinsB.push(join);
			_joins.push(join);
		}
		
		protected function registerNode(a:Object):int
		{
			var i:int = _nodes.indexOf(a);
			
			if (i == -1)
			{
				i = _nodes.length;
				_nodes.push(a);
			}
			
			return i;
		}

		public function areJoined(a:Object, b:Object):Boolean
		{
			var joins:Vector.<GraphJoin> = _joinMap[a];
			if (!joins)
				return false;
			
			var len:uint = joins.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (joins[i].source == b || joins[i].destination == b)
					return true;
			}
			
			return false;
		}
		
	}
}
