package alecmce.data.graph 
{

	public class DirectedAcyclicGraphTest 
	{
		private var graph:DirectedAcyclicGraph;
		
		private var a:Object;
		private var b:Object;
		private var c:Object;

		[Before]
		public function before():void
		{
			a = new MockGraphNode("a");
			b = new MockGraphNode("b");
			c = new MockGraphNode("c");
			graph = new DirectedAcyclicGraph();
		}
		
		[After]
		public function after():void
		{
			a = null;
			b = null;
			c = null;
			
			graph = null;
		}
		
		[Test(expects="Error")]
		public function cyclic_associations():void
		{
			graph.joinNodes(a, b);
			graph.joinNodes(b, c);
			graph.joinNodes(c, a);
		}
		
	}
}
