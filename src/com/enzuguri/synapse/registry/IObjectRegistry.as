
package com.enzuguri.synapse.registry 
{
	import com.enzuguri.synapse.proxy.IInstanceProxy;

	/**
	 * @author Alex Fell
	 */
	public interface IObjectRegistry 
	{
		function hasNamed(name:String):Boolean;
	
		function hasTyped(type:Class):Boolean;
		
		function resolveNamed(name:String, instance:Object = null):*;
		
		function resolveTyped(type:Class, instance:Object = null):*;
		
		function removeNamed(name:String, dispose:Boolean = true):void;
		
		function removeTyped(type:Class, dispose:Boolean = true):void;
		
		function registerProxy(proxy:IInstanceProxy, name:String):void;
		
		function disposeInstance(instance:Object, remove:Boolean = true):void;
		
		function getProxyFromInstance(instance:Object):IInstanceProxy;
	}
}
