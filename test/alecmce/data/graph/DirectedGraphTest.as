package alecmce.data.graph 
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	/**
	 * @author amceachran
	 */
	public class DirectedGraphTest 
	{
		private var graph:DirectedGraph;
		
		private var a:Object;
		private var b:Object;
		private var c:Object;

		[Before]
		public function before():void
		{
			a = new MockGraphNode("a");
			b = new MockGraphNode("b");
			c = new MockGraphNode("c");
			graph = new DirectedGraph();
		}
		
		[After]
		public function after():void
		{
			a = null;			b = null;			c = null;
			
			graph = null;
		}
		
		[Test]
		public function simple_association_is_unidirectional():void
		{
			graph.joinNodes(a, b);
			assertTrue(graph.areJoined(a, b));			assertFalse(graph.areJoined(b, a));
		}
		
	}
}
