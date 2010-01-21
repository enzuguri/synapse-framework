package com.enzuguri.synapse.builder 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	
	
	/**
	 * An IRegistryBuilder is used to configure a given registry by inserting, removing, or updating 
	 * <code>IInstanceProxy</code> definitions based on any given configuration parameters. Typically these builders
	 * are used to 'boot strap' applications, but the <code>addToRegistry()</code> is provided so that the builder
	 * itself can be added to registry for further use.
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface IRegistryBuilder 
	{
		/**
		 * Given an optional number of parameter arguements this configures the given registry. Concreate implementations
		 * of this interface will better describe the intended format of the parameters required.
		 */
		function buildIntoRegistry(registry : IObjectRegistry, ...params) : void;

		
		
		/**
		 * Adds this builder to the given registry.
		 */
		function addToRegistry(registry : IObjectRegistry) : void;
	}
}
