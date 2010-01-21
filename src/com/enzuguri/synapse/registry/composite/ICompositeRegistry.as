package com.enzuguri.synapse.registry.composite 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	
	
	/**
	 * An ICompositeRegistry extends the functionality of the <code>IObjectRegistry</code> interface by allowing
	 * the registry to 'parent' or reference other registries. The intended functionality is a 'bottom-up', where
	 * references are attempted to be resolved locally before considering any attached registries. 
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface ICompositeRegistry 
		extends IObjectRegistry 
	{
		/**
		 * Adds a registry at to the list of registries to be referenced.
		 */
		function addReferenceRegistry(registry : IObjectRegistry) : void;

		
		
		/**
		 * Removes a registry if it is assocaited with this composite.
		 */
		function removeReferenceRegistry(registry : IObjectRegistry) : void;

		
		
		/**
		 * Determines wether this registry holds a reference to the given registry.
		 */
		function hasReferencedRegistry(registry : IObjectRegistry) : Boolean;

		
		
		/**
		 * Lists all the currently referenced registries, this is for order manpulation etc.
		 */
		function listReferencedRegistries() : Array;

		
		
		/**
		 * Removes all references to any referenced registries.
		 */
		function clearReferencedRegistries() : void;
	}
}
