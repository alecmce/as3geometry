package alecmce.invalidation 
{
	import org.osflash.signals.Signal;

	import flash.utils.Dictionary;

	public class InvalidationManager 
	{
		/**
		 * a vector of 'tier' vectors. A tier is a collection of mutually independent
		 * objects which have no dependencies on objects in 'higher tiers'
		 * (tiers with lower indices).
		 */
		private var tiers:Vector.<Vector.<InvalidatesVO>>;
		
		/** contains a map from Invalidates keys to InvalidatesVO values */
		private var voMap:Dictionary;
		
		/** triggered when a new set of invalidations occurs */
		private var _invalidated:Signal;
		
		/** whether there is a managed element that requires resolution */
		private var _requiresResolution:Boolean;

		/**
		 * Constructor
		 */
		public function InvalidationManager() 
		{
			voMap = new Dictionary();
			tiers = new Vector.<Vector.<InvalidatesVO>>();
			tiers[0] = new Vector.<InvalidatesVO>();
			
			_invalidated = new Signal();
			_requiresResolution = false;
		}
		
		/**
		 * add an Invalidates element to be managed
		 */
		public function register(invalidator:Invalidates):void 
		{
			getVO(invalidator);
		}
		
		/**
		 * remove an Invalidates element from management
		 */
		public function unregister(invalidator:Invalidates):void 
		{
			var vo:InvalidatesVO = voMap[invalidator];
			if (!vo)
				return;
			
			var dependees:Vector.<InvalidatesVO> = vo.dependees;
			var len:uint = dependees.length;
			for (var i:uint = 0; i < len; i++)
				removeDependencyVO(vo, dependees[i]);
			
			invalidator.invalidated.remove(onInvalidation);
			delete voMap[invalidator];
		}

		/**
		 * define a relationship that the dependent depends on the independent,
		 * therefore, if the independent invalidates, so too does the dependent, 
		 * though not vice-versa.
		 */
		public function addDependency(independent:Invalidates, dependent:Invalidates):void
		{
			var independentVO:InvalidatesVO = getVO(independent);			var dependentVO:InvalidatesVO = getVO(dependent);
			
			// check whether the dependency already exists
			if (independentVO.dependees.indexOf(dependentVO) != -1)
				return;
			
			// update the tiers, and check for circular dependencies. Do these
			// together to avoid having to recurse twice
			
			// TODO maybe handle circularity as a 'next round of inavlidation'?
			if (!updateTiersAndCheckCircularity(independentVO, independentVO, dependentVO))
				throw new Error("The InvalidationManager does not accept circular dependencies");
			
			// cross-register the dependencies
			independentVO.dependees.push(dependentVO);			dependentVO.dependencies.push(independentVO);
			
			// if the independent is currently invalid, so too is the dependent
			if (independent.isInvalid)
				dependent.invalidate();
		}
		
		/**
		 * remove a dependency relation between an independent Invalidates and a
		 * previously dependent invalidates
		 */
		public function removeDependency(independent:Invalidates, dependent:Invalidates):void 
		{
			var independentVO:InvalidatesVO = voMap[independent];			var dependentVO:InvalidatesVO = voMap[dependent];
			
			if (!independentVO || !dependentVO)
				return;
		
			removeDependencyVO(independentVO, dependentVO);
		}
		
		/**
		 * does the leg-work of removing a dependency. This method may have been called by 
		 * the removeDependency method, or by the unregister method
		 */
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
		
		/**
		 * after removing dependencies ensure that empty tiers are removed, to preserve the
		 * compactness of the tiers vector
		 */
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

		
		/**
		 * either reference a VO for an Invalidates object, or create a new VO
		 */
		private function getVO(invalidates:Invalidates):InvalidatesVO
		{
			var vo:InvalidatesVO = voMap[invalidates];
			if (vo)
				return vo;
				
			invalidates.invalidated.add(onInvalidation);
			voMap[invalidates] = vo = new InvalidatesVO(invalidates);
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
			
			while (tiers.length <= dependentTier)
				tiers.push(new Vector.<InvalidatesVO>());
			
			var dependees:Vector.<InvalidatesVO> = dependent.dependees;
			var len:uint = dependees.length;
			for (var i:uint = 0; i < len; i++)
			{
				if (!updateTiersAndCheckCircularity(root, dependent, dependees[i]))
					return false;
			}
			
			return true;
		}

		private function onInvalidation(invalidator:Invalidates, resolveImmediately:Boolean = false):void 
		{
			var vo:InvalidatesVO = voMap[invalidator];
			var tier:uint = vo.tier;
			
			if (!vo.isInvalidated)
			{
				vo.isInvalidated = true;
			
				var invalidations:Vector.<InvalidatesVO> = tiers[tier];
				if (!invalidations)
					tiers[tier] = invalidations = new Vector.<InvalidatesVO>();
				
				invalidations.push(vo);	
				
				var dependees:Vector.<InvalidatesVO> = vo.dependees;
				var len:uint = dependees.length;
				for (var i:uint = 0; i < len; i++)
					dependees[i].target.invalidate();
			}
			
			var newInvalidation:Boolean = !_requiresResolution;
			_requiresResolution = true;
			
			if (resolveImmediately)
				resolve();
			else if (newInvalidation)
				_invalidated.dispatch();
			
			_requiresResolution = !resolveImmediately;
		}
		
		public function get requiresResolution():Boolean
		{
			return _requiresResolution;
		}

		public function resolve():void 
		{
			if (!_requiresResolution)
				return;
			
			var ilen:uint = tiers.length;
			for (var i:uint = 0; i < ilen; i++)
			{
				var invalidations:Vector.<InvalidatesVO> = tiers[i];
				var jlen:uint = invalidations.length;
				for (var j:uint = 0; j < jlen; j++)
					invalidations[j].resolve();
				
				invalidations.length = 0;
			}
			
			_requiresResolution = false;
		}
		
		public function get invalidated():Signal
		{
			return _invalidated;
		}
	}
}
