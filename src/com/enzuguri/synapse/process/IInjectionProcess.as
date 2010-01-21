package com.enzuguri.synapse.process 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	
	
	/**
	 * An IInjectionProcess performs dependancy injection on a given object. Processes can be ordered and contain
	 * utility methods for disposal (such as garbage colelction) and 'uninjection' (where the injection process is
	 * reversed)
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface IInjectionProcess 
	{
		/**
		 * Removes any references to internal variables to free up for garbage collection.
		 */
		function dispose() : void;

		
		
		/**
		 * Applies the injection to the given target and returns an object that is the result of that injection.
		 * Any references required by the process can be resolved using the given registry.
		 */
		function applyInjection(registry : IObjectRegistry, target : Object) : Object;

		
		
		/**
		 * Provides an 'undo' method. The registry object is given so that any interaction with other objects
		 * can be removed. The object returned is the result of the 'uninjection' process.
		 */
		function removeInjection(registry : IObjectRegistry, target : Object) : Object;

		
		
		/**
		 * Returns the order or priority of this process when it was configured, however this can be
		 * manipulated depending on the implementation of a 'processQueue'.
		 */
		function get order() : int;
	}
}
