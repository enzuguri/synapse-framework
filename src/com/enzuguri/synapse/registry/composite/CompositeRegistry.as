package com.enzuguri.synapse.registry.composite 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.registry.ObjectRegistry;

	/**
	 * @author alex
	 */
	public class CompositeRegistry extends ObjectRegistry implements ICompositeRegistry 
	{
		protected var _referencedRegistries : Array;
		
		public function CompositeRegistry(autoAdd : Boolean = true)
		{
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
		
		protected function retrieveFromReferencedRegistries(name:String):*
		{
			var len : int = _referencedRegistries.length;
			var result:Object;
			for (var i : int = 0; i < len; i++) 
			{
				result = (_referencedRegistries[i] as IObjectRegistry).retrieveNamed(name);
				if (result)
					break;
			}
			return result;
		}

		override public function retrieveNamed(name : String) : *
		{
			var result:Object = super.retrieveNamed(name);
			if(!result)
				return retrieveFromReferencedRegistries(name);
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
	}
}
