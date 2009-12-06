package as3geometry.geom2D 
{
	import as3geometry.geom2D.util.AllUtilTests;
	import as3geometry.geom2D.immutable.AllImmutableTests;
	import as3geometry.geom2D.intersection.AllIntersectionTests;
	import as3geometry.geom2D.mutable.AllMutableTests;

	[Suite]
	public class AllGeom2DTests 
	{
		public var immutableTests:AllImmutableTests;		public var intersectionTests:AllIntersectionTests;		public var mutableTests:AllMutableTests;		public var utilTests:AllUtilTests;
	}
}
