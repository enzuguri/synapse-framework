
package com.enzuguri.synapse.builder 
{

	import com.enzuguri.synapse.registry.IObjectRegistry;
	/**
	 * @author Alex Fell
	 */
	public interface IRegistryBuilder 
	{
		function buildIntoRegistry(registry:IObjectRegistry, ...params):void;
	}
}
