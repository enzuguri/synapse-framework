package com.enzuguri.synapse.wire 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.IEventDispatcher;

	
	
	/**
	 * The IWiringController is the central event bus for the application.
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface IWiringController 
		extends IEventDispatcher 
	{
		/**
		 * Removes an <code>EventCallback</code> from this controller so that is cannot be triggered by
		 * further events.
		 */
		function removeCallback(callback : EventCallback) : void;

		
		
		/**
		 * Registers an <code>EventCallback</code> so that it can be triggered by events dispatching on this
		 * controller.
		 */
		function registerCallback(callback : EventCallback) : void;

		
		
		/**
		 * Sets a reference to the corresponding registry used in conjunction with this controller.
		 */
		function set registry(value : IObjectRegistry) : void;

		
		
		/**
		 * A utility method for adding many listeners to a given dispatcher. Each element in the array specificies
		 * and event type to be watched by this controller.
		 */
		function watchDispatcher(dispatcher : IEventDispatcher, eventTypes : Array) : void;

		
		
		/**
		 * A utility method for removing event listeners from the controller. Each element in the array specificies
		 * and event type to be removed.
		 */
		function ignoreDispatcher(dispatcher : IEventDispatcher, eventTypes : Array) : void;
	}
}
