package com.enzuguri.synapse.dispatcher 
{
	import flash.utils.Dictionary;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author alex
	 */
	public class ClearableDispatcher 
		extends EventDispatcher
			implements IClearableDispatcher 
	{
		protected var listenerCache : Dictionary;
		
		public function ClearableDispatcher(target : IEventDispatcher = null)
		{
			super(target);
			listenerCache = new Dictionary();
		}

		
		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			var cachedListeners:Array = listenerCache[type];
			
			if(!cachedListeners)
				cachedListeners = listenerCache[type] = [];
			
			cachedListeners[cachedListeners.length] = listener;
			
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			var cachedListeners:Array = listenerCache[type];
			
			if(cachedListeners && cachedListeners.length > 0)
			{
				var index : int = cachedListeners.indexOf(listener);
				if(index > -1)
					cachedListeners.splice(index, 1);
					
				if(cachedListeners.length == 0)
					delete listenerCache[type];	
			}
			
			super.removeEventListener(type, listener, useCapture);
		}

		public function clearListeners() : void
		{
			var cachedListeners:Array;
			for (var type : String in listenerCache) 
			{
				cachedListeners = listenerCache[type];
				if(cachedListeners)
				{
					var length:int = cachedListeners.length; 
					while(length--)
					{
						removeEventListener(type, cachedListeners[length]);
					}
				}
				delete listenerCache[type];
			}
			
			listenerCache = new Dictionary();
		}
	}
}
