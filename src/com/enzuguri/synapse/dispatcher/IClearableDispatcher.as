package com.enzuguri.synapse.dispatcher 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * @author alex
	 */
	public interface IClearableDispatcher 
		extends IEventDispatcher 
	{
		function clearListeners():void;
	}
}
