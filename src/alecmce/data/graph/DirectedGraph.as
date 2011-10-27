package alecmce.data.graph
{
	public class DirectedGraph extends Graph
	{
		public function DirectedGraph()
		{
			super();
		}

		override public function joinNodes(a:Object, b:Object, cost:Number = 1):void
		{
			registerNode(a);
			registerNode(b);

			var joins:Vector.<GraphJoin> = (_joinMap[a] ||= new Vector.<GraphJoin>());
			var join:GraphJoin = new GraphJoin(a, b, cost);

			joins.push(join);
			_joins.push(join);
		}

		override public function areJoined(a:Object, b:Object):Boolean
		{
			var joins:Vector.<GraphJoin> = _joinMap[a];
			if (!joins)
				return false;

			var len:uint = joins.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (joins[i].destination == b)
					return true;
			}

			return false;
		}
	}
}
