package com.enzuguri.synapse.registry.composite 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.registry.ObjectRegistry;

	/**
	 * @author alex
	 */
	public class CompositeRegistry 
		extends ObjectRegistry 
			implements ICompositeRegistry 
	{
		protected var _referencedRegistries : Array;
		
		public function CompositeRegistry(autoAdd : Boolean = true)
		{
			_referencedRegistries = [];
			super(autoAdd);
		}
		
		public function addReferenceRegistry(registry : IObjectRegistry) : void
		{
			if(_referencedRegistries.indexOf(registry) == -1)
				_referencedRegistries[_referencedRegistries.length] = registry;
		}

		public function removeReferenceRegistry(registry : IObjectRegistry) : void
		{
			
		}
		
		protected function resolveNameFromRegistries(name:String, target:Object = null):*
		{
			var len : int = _referencedRegistries.length;
			var result:Object;
			for (var i : int = 0; i < len; i++) 
			{
				result = (_referencedRegistries[i] as IObjectRegistry).resolveNamed(name, target);
				if (result)
					break;
			}
			return result;
		}

		protected function resolveTypeFromRegistries(type:Class, target:Object = null):*
		{
			var len : int = _referencedRegistries.length;
			var result:Object;
			for (var i : int = 0; i < len; i++) 
			{
				result = (_referencedRegistries[i] as IObjectRegistry).resolveTyped(type, target);
				if (result)
					break;
			}
			return result;
		}

		override public function resolveNamed(name : String, target:Object = null) : *
		{
			var result:Object = super.resolveNamed(name, target);
			if(!result)
				return resolveNameFromRegistries(name, target);
			return result;
		}

		override public function resolveTyped(type : Class, target:Object = null) : *
		{
			var result:Object = super.resolveTyped(type, target);
			if(!result)
				return resolveTypeFromRegistries(type, target);
			return result;
		}
		
		public function listReferencedRegistries() : Array
		{
			return _referencedRegistries;
		}
		
		public function clearReferencedRegistries() : void
		{
			_referencedRegistries.length = 0;
		}
		
		
		
		public function hasReferencedRegistry(registry : IObjectRegistry) : Boolean
		{
			return _referencedRegistries.indexOf(registry) > -1;
		}
	}
}
