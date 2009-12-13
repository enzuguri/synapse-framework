package com.enzuguri.synapse.proxy 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author alex
	 */
	public interface IInstanceProxy 
	{
		function get currentInstance() :Object;
		
		function get processList():Array;
		
		function dispose(registry:IObjectRegistry):void;
		
		function disposeInstance(registry:IObjectRegistry, instance:Object = null):void;
		
		function addProcess(process:IInjectionProcess):void;
		
		function get type():String;
		
		function get clazz():Class;
		
		function get name() : String;
		
		function matchesInstance(instance : Object) : Boolean;
		
		function resolve(registry:IObjectRegistry):*;
		
		function get processed():Boolean;
	}
}
