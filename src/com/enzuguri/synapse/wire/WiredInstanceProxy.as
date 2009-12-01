package com.enzuguri.synapse.wire 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author alex
	 */
	public class WiredInstanceProxy 
		implements IInstanceProxy
	{
		private var _proxy : IInstanceProxy;
		private var _events : Array;
		private var _controller : IWiringController;
		private var _callbacks : Array;

		public function WiredInstanceProxy(proxy:IInstanceProxy, controller:IWiringController, events:Array = null) 
		{
			_controller = controller;
			_events = events || [];
			_proxy = proxy;
			_callbacks = [];
		}
		
		public function addCallback(callback:EventCallback):void
		{
			if(callback)
			{
				_callbacks[_callbacks.length] = callback;
				_controller.registerProxyEvents(this, callback.types);
			}
		}

		public function recieveEvent(event : Event, instance:Object) : void
		{
			var len:int = _callbacks.length;
			var callback:EventCallback;
			for (var i : int = 0;i < len; i++) 
			{
				callback = _callbacks[i];
				if(callback.isTriggeredBy(event))
					callback.executeCallback(event, instance);
			}
		}
		
		public function disposeInstance(instance : Object = null) : void
		{
			removeListeners(instance as IEventDispatcher);
			_proxy.disposeInstance(instance);
		}
		
		private function removeListeners(dispatcher : IEventDispatcher) : void
		{
			if(dispatcher)
			{
				var len : int = _events.length;
				for (var i : int = 0; i < len; i++) 
				{
					dispatcher.removeEventListener(_events[i], _controller.triggerEvent);
				}
			}
		}

		public function addProcess(process : IInjectionProcess) : void
		{
			_proxy.addProcess(process);
		}

		public function matchesInstance(instance : Object) : Boolean
		{
			return _proxy.matchesInstance(instance);
		}

		public function resolve(registry : IObjectRegistry) : *
		{
			if(!currentInstance)
			{
				var object:Object = _proxy.resolve(registry);
				configureListeners(object as IEventDispatcher);	
			}
			
			return object || currentInstance;
		}

		private function configureListeners(dispatcher : IEventDispatcher) : void
		{
			trace("configuring listeners on new dispatcher", dispatcher);
			if(dispatcher)
			{
				var len : int = _events.length;
				for (var i : int = 0; i < len; i++) 
				{
					dispatcher.addEventListener(_events[i], _controller.triggerEvent);
				}
			}
		}

		public function get type() : String
		{
			return _proxy.type;
		}

		public function get clazz() : Class
		{
			return _proxy.clazz;
		}

		public function get name() : String
		{
			return _proxy.name;
		}
		
		public function get currentInstance() : Object
		{
			return _proxy.currentInstance;
		}
	}
}