package alecmce.invalidation 
{
	internal class InvalidatesVO 
	{
		
		public var target:Invalidates;
		public var dependencies:Vector.<InvalidatesVO>;		public var dependees:Vector.<InvalidatesVO>;
		public var tier:uint;

		public function InvalidatesVO(target:Invalidates) 
		{
			this.target = target;
			this.dependencies = new Vector.<InvalidatesVO>();			this.dependees = new Vector.<InvalidatesVO>();
			this.tier = 0;
		}
		
		
		
	}
}
