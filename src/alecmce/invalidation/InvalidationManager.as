package alecmce.invalidation 
{
	import flash.utils.Dictionary;

	public class InvalidationManager implements Invalidates
	{
		private var _members:Dictionary;
		private var _invalidations:Vector.<Vector.<Invalidates>>;
		
		private var _invalidated:InvalidationSignal;
		
		private var _isInvalid:Boolean;

		public function InvalidationManager() 
		{
			_members = new Dictionary();
			_invalidations = new Vector.<Vector.<Invalidates>>();
			_invalidations[0] = new Vector.<Invalidates>();
			_isInvalid = false;
		}
		
		public function register(invalidator:Invalidates):void 
		{
			getVO(invalidator);
		}
		
		public function unregister(invalidator:Invalidates):void 
		{
			var vo:InvalidatesVO = _members[invalidator];
			if (!vo)
				return;
			
			var dependees:Vector.<InvalidatesVO> = vo.dependees;
			var len:uint = dependees.length;
			for (var i:uint = 0; i < len; i++)
				removeDependencyVO(vo, dependees[i]);
			
			invalidator.invalidated.remove(onInvalidation);
			delete _members[invalidator];
		}

		/**
		 * define a relationship that the dependent depends on the independent,
		 * therefore, if the independent invalidates, so too does the dependent.
		 */
		public function addDependency(independent:Invalidates, dependent:Invalidates):void 
		{
			var independentVO:InvalidatesVO = getVO(independent);			var dependentVO:InvalidatesVO = getVO(dependent);
			
			// check whether the dependency already exists
			if (independentVO.dependees.indexOf(dependentVO) != -1)
				return;
			
			// update the tiers, and check for circular dependencies. Do these
			// together to avoid having to recurse twice
			if (!updateTiersAndCheckCircularity(independentVO, independentVO, dependentVO))
				throw new Error("The InvalidationManager does not accept circular dependencies");
			
			// cross-register the dependencies
			independentVO.dependees.push(dependentVO);			dependentVO.dependencies.push(independentVO);
			
			// if the independent is currently invalid, so too is the dependent
			if (independent.isInvalid)
				dependent.invalidate();
		}
		
		public function removeDependency(independent:Invalidates, dependent:Invalidates):void 
		{
			var independentVO:InvalidatesVO = _members[independent];			var dependentVO:InvalidatesVO = _members[dependent];
			
				if (!independentVO || !dependentVO)
				return;
		
			removeDependencyVO(independentVO, dependentVO);
		}
		
		private function removeDependencyVO(independent:InvalidatesVO, dependent:InvalidatesVO):void
		{
			var list:Vector.<InvalidatesVO> = independent.dependees;
			var i:int = list.indexOf(dependent);
			if (i != -1)
				list.splice(i, 1);
			
			list = dependent.dependencies;			i = list.indexOf(independent);
			if (i != -1)
				list.splice(i, 1);
			
			minimizeTiers(dependent);
		}
		
		private function minimizeTiers(vo:InvalidatesVO):void
		{
			var list:Vector.<InvalidatesVO> = vo.dependencies;
			var len:uint = list.length;
			var max:uint = 0;
			var i:uint;
			
			for (i = 0; i < len; i++)
			{
				var tier:uint = list[i].tier;
				if (tier > max)
					max = tier;
			}
			
			if (++max >= vo.tier)
				return;
			
			vo.tier = max;
			
			list = vo.dependees;
			len = list.length;
			for (i = 0; i < len; i++)
				minimizeTiers(list[i]);
		}

		
		private function getVO(invalidates:Invalidates):InvalidatesVO
		{
			var vo:InvalidatesVO = _members[invalidates];
			if (vo)
				return vo;
				
			invalidates.invalidated.add(onInvalidation);
			_members[invalidates] = vo = new InvalidatesVO(invalidates);
			return vo;
		}

		private function updateTiersAndCheckCircularity(root:InvalidatesVO, independent:InvalidatesVO, dependent:InvalidatesVO):Boolean 
		{
			if (root == dependent)
				return false;
			
			var independentTier:uint = independent.tier;
			var dependentTier:uint = dependent.tier;
			
			// ensure that the dependent has a higher tier than the independent and that this
			// knocks on to all 
			if (dependentTier > independentTier)
				return true;
				
			dependent.tier = dependentTier = independentTier + 1;
			
			while (_invalidations.length <= dependentTier)
				_invalidations.push(new Vector.<Invalidates>());
			
			var dependees:Vector.<InvalidatesVO> = dependent.dependees;
			var len:uint = dependees.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (!updateTiersAndCheckCircularity(root, dependent, dependees[i]))
					return false;
			}
			
			return true;
		}

		private function onInvalidation(invalidator:Invalidates):void 
		{
			var vo:InvalidatesVO = _members[invalidator];
			var tier:uint = vo.tier;
			
			var invalidations:Vector.<Invalidates> = _invalidations[tier];
			if (!invalidations)
				_invalidations[tier] = invalidations = new Vector.<Invalidates>();
			
			invalidations.push(invalidator);	
			
			var dependees:Vector.<InvalidatesVO> = vo.dependees;
			var len:uint = dependees.length;
			for (var i:uint = 0; i < len; i++)
				dependees[i].target.invalidate();
			
			if (_isInvalid)
				return;
			
			invalidate();
		}
		
		public function get requiresResolution():Boolean
		{
			return _isInvalid;
		}
		
		public function invalidate():void
		{
			_isInvalid = true;
			_invalidated.dispatch(this);
		}

		public function get invalidated():InvalidationSignal
		{
			return _invalidated;
		}
		
		public function get isInvalid():Boolean
		{
			return _isInvalid;
		}
		
		public function resolve():void 
		{
			var ilen:uint = _invalidations.length;
			for (var i:uint = 0; i < ilen; i++)
			{
				var invalidations:Vector.<Invalidates> = _invalidations[i];
				var jlen:uint = invalidations.length;
				for (var j:uint = 0; j < jlen; j++)
					invalidations[j].resolve();
				
				invalidations.length = 0;
			}
			
			_isInvalid = false;
		}
	}
}
