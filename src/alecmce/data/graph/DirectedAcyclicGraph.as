package alecmce.data.graph
{
	import alecmce.data.bitwise.BitField;
	import alecmce.data.bitwise.BitFieldUtil;

	import flash.utils.Dictionary;

	public class DirectedAcyclicGraph extends DirectedGraph
	{
		private var _util:BitFieldUtil;
		private var _reverseJoinReferences:Dictionary;

		public function DirectedAcyclicGraph()
		{
			super();

			_util = new BitFieldUtil();
			_reverseJoinReferences = new Dictionary();
		}

		override public function joinNodes(a:Object, b:Object, cost:Number = 1):void
		{
			var bitA:int = registerNode(a);
			var bitB:int = registerNode(b);

			var fieldA:BitField = _reverseJoinReferences[a];
			if (!fieldA)
				_reverseJoinReferences[a] = fieldA = new BitField();

			if (fieldA.getBit(bitB))
				throw new Error("Attempted join would create a cyclic graph");

			fieldA = fieldA.clone();
			fieldA.setBit(bitA, true);

			assignBits(b, fieldA);
			super.joinNodes(a, b, cost);
		}

		private function assignBits(b:Object, fieldA:BitField):void
		{
			var fieldB:BitField = _reverseJoinReferences[b];
			if (fieldB)
				fieldB = _util.or(fieldA, fieldB);
			else
				fieldB = fieldA.clone();

			_reverseJoinReferences[b] = fieldB;

			var joins:Vector.<GraphJoin> = _joinMap[b];
			for each (var join:GraphJoin in joins)
				assignBits(join.destination, fieldA);
		}

	}
}
