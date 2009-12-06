package com.enzuguri.synapse.wire 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.IEventDispatcher;

	/**
	 * @author alex
	 */
	public interface IWiringController 
		extends IEventDispatcher 
	{
		function removeCallback(callback : EventCallback) : void;
		
		function registerCallback(callback : EventCallback) : void;
		
		function set registry(value:IObjectRegistry):void;
		
		function watchDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void;
		
		function ignoreDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void;


	}
}
