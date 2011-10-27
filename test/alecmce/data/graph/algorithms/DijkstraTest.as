package alecmce.data.graph.algorithms
{
	import alecmce.data.graph.DirectedGraph;
	import alecmce.data.graph.MockGraphNode;

	import asunit.asserts.assertEquals;
	import asunit.asserts.assertSame;

	public class DijkstraTest
	{

		private var graph:DirectedGraph;
		private var algorithm:Dijkstra;

		private var a:Object;
		private var b:Object;
		private var c:Object;

		[Before]
		public function before():void
		{
			graph = new DirectedGraph();
			a = new MockGraphNode("a");
			b = new MockGraphNode("b");
			c = new MockGraphNode("c");
			algorithm = new Dijkstra();
		}

		[After]
		public function after():void
		{
			a = null;
			b = null;
			c = null;

			algorithm = null;
			graph = null;
		}

		private function basicJoin():void
		{
			graph.joinNodes(a, b, 2);
			graph.joinNodes(b, c, 3);
		}

		[Test]
		public function basic_join_test_cost():void
		{
			basicJoin();
			algorithm.apply(graph, a);
			assertEquals(5, algorithm.getCost(c));
		}

		[Test]
		public function basic_join_test_route():void
		{
			basicJoin();
			algorithm.apply(graph, a);

			var route:Vector.<Object> = algorithm.getRoute(c);
			assertSame(a, route[0]);			assertSame(b, route[1]);			assertSame(c, route[2]);
		}
	}
}
