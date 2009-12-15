
package com.enzuguri.synapse.process 
{

	import com.enzuguri.synapse.registry.IObjectRegistry;
	/**
	 * @author Alex Fell
	 */
	public interface IInjectionProcess 
	{
		function dispose():void;
		
		function applyInjection(registry:IObjectRegistry, target:Object):Object;
		
		function removeInjection(registry:IObjectRegistry, target:Object):Object;
		
		function get order():int;
	}
}
