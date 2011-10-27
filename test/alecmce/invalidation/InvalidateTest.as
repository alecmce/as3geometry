package alecmce.invalidation
{
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	public class InvalidateTest
	{
		private var a:Invalidates;
		private var b:Invalidates;
		private var c:Invalidates;
		private var manager:InvalidationManager;

		[Before]
		public function before():void
		{
			manager = new InvalidationManager();
			a = new ExampleInvalidator("a");			b = new ExampleInvalidator("b");			c = new ExampleInvalidator("c");
		}

		[After]
		public function after():void
		{
			manager = null;
			a = null;			b = null;
		}

		[Test]
		public function simple_invalidation():void
		{
			a.invalidate();
			assertTrue(a.isInvalid);

			a.resolve();
			assertFalse(a.isInvalid);
		}

		[Test]
		public function simple_invalidation_cycle():void
		{
			manager.register(a);
			a.invalidate();

			manager.resolve();
			assertFalse(a.isInvalid);
		}

		[Test]
		public function simple_invalidation_dependency_cycle():void
		{
			manager.register(a);
			manager.register(b);
			manager.addDependency(a, b);

			a.invalidate();
			assertTrue(b.isInvalid);

			manager.resolve();
			assertFalse(b.isInvalid);
		}

		[Test]
		public function registration_is_inferred_by_dependencies():void
		{
			manager.addDependency(a, b);

			a.invalidate();
			assertTrue(b.isInvalid);
		}

		[Test]
		public function dependency_is_transitive():void
		{
			manager.register(a);
			manager.register(b);
			manager.register(c);
			manager.addDependency(a, b);			manager.addDependency(b, c);

			a.invalidate();
			assertTrue(c.isInvalid);

			manager.resolve();
			assertFalse(a.isInvalid);
			assertFalse(b.isInvalid);
			assertFalse(c.isInvalid);
		}

		[Test(expects="Error")]
		public function dependencies_cannot_be_circular():void
		{
			manager.register(a);
			manager.register(b);
			manager.register(c);
			manager.addDependency(a, b);			manager.addDependency(b, c);			manager.addDependency(c, a);
		}

		[Test]
		public function dependencies_can_be_removed():void
		{
			manager.addDependency(a, b);
			manager.removeDependency(a, b);

			a.invalidate();
			assertFalse(b.isInvalid);
		}

		[Test]
		public function invalidators_can_be_removed():void
		{
			manager.addDependency(a, b);
			manager.unregister(a);

			a.invalidate();
			assertFalse(b.isInvalid);		}

	}
}
