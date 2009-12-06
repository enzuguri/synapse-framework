package com.enzuguri.synapse.wire 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;

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
				callback.targetName = name;
				_callbacks[_callbacks.length] = callback;
				_controller.registerCallback(callback);
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
			var object:Object;
			if(!currentInstance && !processed)
			{
				object = _proxy.resolve(registry);
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
			var callback:EventCallback;
			while(i--)
			{
				callback = _callbacks[i];
				_controller.removeCallback(callback);
				callback.dispose();
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
		
		public function get processed() : Boolean
		{
			return _proxy.processed;
		}
	}
}
