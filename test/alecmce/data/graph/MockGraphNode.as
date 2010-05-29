package alecmce.data.graph 
{
	public class MockGraphNode 
	{
		private var _id:String;
		
		public function MockGraphNode(id:String)
		{
			_id = id;
		}

		public function toString():String 
		{
			return _id;
		}
	}
}
