
package com.enzuguri.synapse.process 
{

	import com.enzuguri.synapse.registry.IObjectRegistry;
	/**
	 * @author Alex Fell
	 */
	public interface IInjectionProcess 
	{
		function execute(registry:IObjectRegistry, target:Object):Object
	}
}
