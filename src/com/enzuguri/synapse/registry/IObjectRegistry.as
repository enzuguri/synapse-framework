
package com.enzuguri.synapse.registry 
{

	import com.enzuguri.synapse.proxy.InstanceProxy;
	/**
	 * @author Alex Fell
	 */
	public interface IObjectRegistry 
	{
		function retrieveNamed(name:String):*;
		
		function retrieveTyped(type:Class):*;
		
		function registerInstance(instance:InstanceProxy, name:String):void;
	}
}
