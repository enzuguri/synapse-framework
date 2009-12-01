package com.enzuguri.synapse.wire 
{
	import flash.events.IEventDispatcher;

	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * @author alex
	 */
	public class WiringController 
		implements IWiringController 
	{
		
		protected var _proxyMap : Dictionary;
		
		protected var _registry:IObjectRegistry;		
		
		public function WiringController() 
		{
			_proxyMap = new Dictionary();
		}
		
		public function triggerEvent(event : Event) : void
		{
			trace("trigger the wiring controller!!", _registry, event.type);
			var proxies:Array = _proxyMap[event.type];
			
			if(proxies)
			{
				var len : int = proxies.length;
				var proxy:WiredInstanceProxy;
				for (var i : int = 0; i < len; i++) 
				{
					proxy = proxies[i] as WiredInstanceProxy;
					proxy.recieveEvent(event, proxy.resolve(_registry));
				}
			}
			
		}
		
		public function registerProxyEvents(proxy : WiredInstanceProxy, types : Array) : void
		{
			var len:int = types.length;
			var type:String;
			
			for (var i : int = 0; i < len; i++) 
			{
				type = types[i];
				var proxies:Array = _proxyMap[type];
				if(!proxies)
					proxies = _proxyMap[type] = [proxy];
				else if(proxies.indexOf(proxy) == -1)	
					proxies[proxies.length] = proxy;
			}
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
					dispatcher.addEventListener(eventTypes[i], triggerEvent);
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
					dispatcher.removeEventListener(eventTypes[i], triggerEvent);
				}
			}
		}
	}
}
