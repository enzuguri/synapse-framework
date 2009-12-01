package com.enzuguri.synapse.wire 
{
	import flash.events.IEventDispatcher;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public interface IWiringController 
	{
		function registerProxyEvents(proxy : WiredInstanceProxy, types:Array) : void;
		
		function triggerEvent(event:Event):void;
		
		function set registry(value:IObjectRegistry):void;
		
		function watchDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void;
		
		function ignoreDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void;


	}
}
