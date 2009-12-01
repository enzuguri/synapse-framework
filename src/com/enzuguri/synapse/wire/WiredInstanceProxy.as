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
			_controller.ignoreDispatcher(instance as IEventDispatcher, _events);
			_proxy.disposeInstance(instance);
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
				_controller.watchDispatcher(object as IEventDispatcher, _events);	
			}
			
			return object || currentInstance;
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
		
		
		
		public function dispose():void
		{
			_proxy.dispose();
			
			var i:int = _callbacks.length;
			while(i--)
			{
				(_callbacks[i] as EventCallback).dispose();
			}
			_callbacks.length = 0;
			_callbacks = null;
			_controller = null;
			_events.length = 0;
			_events = null;
		}
		
		
		
		public function get processList():Array
		{
			return _proxy.processList;
		}
	}
}
