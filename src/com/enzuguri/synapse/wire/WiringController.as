package com.enzuguri.synapse.wire 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * @author alex
	 */
	public class WiringController 
		extends EventDispatcher
			implements IWiringController 
	{
		
		protected var _registry:IObjectRegistry;
		protected var _callbackMap : Dictionary;		

		public function WiringController() 
		{
			_callbackMap = new Dictionary();
		}
		
		override public function dispatchEvent(event : Event) : Boolean
		{
			var callbacks:Array = _callbackMap[event.type];
			
			if (!callbacks)
				return super.dispatchEvent(event);
			
			var success:Boolean = true;
			var len:int = callbacks.length;
			
			var callback:EventCallback;
			
			for (var i : int = 0; i < len; i++) 
			{
				callback = callbacks[i];
				success = callback.executeCallback(event, callback.resolveTarget(_registry));
				if(!success)
					break;
			}
			
			return success && super.dispatchEvent(event);
		}
		
		public function set registry(value:IObjectRegistry) : void
		{
			_registry = value;
		}
		
		
		public function watchDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void
		{
			if(dispatcher)
			{
				var len : int = eventTypes.length;
				for (var i : int = 0; i < len; i++) 
				{
					dispatcher.addEventListener(eventTypes[i], dispatchEvent);
				}
			}
		}
		
		
		public function ignoreDispatcher(dispatcher:IEventDispatcher, eventTypes:Array):void
		{
			if(dispatcher)
			{
				var len : int = eventTypes.length;
				for (var i : int = 0; i < len; i++) 
				{
					dispatcher.removeEventListener(eventTypes[i], dispatchEvent);
				}
			}
		}
		
		public function registerCallback(callback : EventCallback) : void
		{
			var callbacks:Array = _callbackMap[callback.type];
			if(!callbacks)
				callbacks = _callbackMap[callback.type] = [];
				
			callbacks[callbacks.length] = callback;
			
			callbacks.sortOn("priority", Array.DESCENDING);	
		}
		
		public function removeCallback(callback : EventCallback) : void
		{
			var callbacks:Array = _callbackMap[callback.type];
			if(!callbacks)
			{
				var index : int = callbacks.indexOf(callback);
				if(index > -1)
					callbacks.splice(index, 1);
			}
		}
		
		override public function toString() : String 
		{
			var dictArray:Array = [];
			
			for (var eventName : String in _callbackMap) 
			{
				dictArray[dictArray.length] = eventName + ":\n[\n" + (_callbackMap[eventName] as Array).join(", \n") + "\n]";
			}
			
			var strout:String = "WiringController\n{" + 
								"\n\tregistry:" + _registry + 
								"\n\tcallbackMap:\n\t" + dictArray.join(", \n\t") + 
								"}";
			return strout;
		}
	}
}
