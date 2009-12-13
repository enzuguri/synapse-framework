package com.enzuguri.synapse.builder.wire 
{
	import com.enzuguri.synapse.builder.asmetadata.ASMetaDataBuilder;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.wire.EventCallback;
	import com.enzuguri.synapse.wire.IWiringController;
	import com.enzuguri.synapse.wire.WiringController;
	import com.enzuguri.synapse.wire.process.InjectCallbackProcess;
	import com.enzuguri.synapse.wire.process.WatchWireProcess;

	/**
	 * @author alex
	 */
	public class ASWireBuilder 
		extends ASMetaDataBuilder 
	{
		protected var _controller : IWiringController;
		
		private var _controllerName:String;

		
		
		public function ASWireBuilder(autoAdd:Boolean = true, controllerName:String = "")
		{
			_controllerName = controllerName != "" ? controllerName : getClassName(IWiringController);
			_controller = new WiringController();
			super(autoAdd);
		}

		override protected function postProcess(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			return determineEvents(description, proxy);
		}
		
		private function determineEvents(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			for each (var watchNode:XML in description.factory.metadata.(@name == "Wire"))
				createWatchProcesses(watchNode, proxy);
			
			for each (var node:XML in description.factory.method.metadata.(@name == "Wire"))
				createEventCallbacks(node, proxy);
				
			return proxy;
		}

		
		
		private function createWatchProcesses(watchNode:XML, proxy:IInstanceProxy):void
		{
			var types:Array = [];
			var controllerName:String = _controllerName;
			
			for each (var argument : XML in watchNode.elements("arg")) 
			{
				if(argument.@key == "controller")
					controllerName = String(argument.@value);
				else if(argument.@key == "dispatch")
					types = String(argument.@value).split(",");
			}
			
			if(types.length > 0)
				proxy.addProcess(new WatchWireProcess(types, controllerName));
		}

		
		
		private function createEventCallbacks(node:XML, proxy:IInstanceProxy) : void
		{
			var types:Array = [];
			var controllerName:String = _controllerName;
			var translations:Array;
			var priority:int = 0;
			var methodName:String = node.parent().@name;
			var autoWake:Boolean = true;
			
			for each(var arg:XML in node.arg)
			{
				switch(String(arg.@key))
				{
					case "handle":
						types = String(arg.@value).split(",");
						break;
					case "translations":
						translations = String(arg.@value).split(",");
						break;
					case "order":
						priority = parseInt(arg.@value);
						break;
					case "controller":
						controllerName = _controllerName;
						break;
					case "wake":
						autoWake = String(arg.@value) != "false";
						break;		
								
				}
			}
			
			var len:int = types.length;
			for (var i : int = 0; i < len; i++) 
			{
				var callback:EventCallback = new EventCallback(types[i], methodName, priority, translations);
				callback.targetName = proxy.name;
				var process:InjectCallbackProcess = new InjectCallbackProcess(callback, controllerName);
				
				if(autoWake)
				{
					process.wired = true;
					_controller.registerCallback(callback);
				}
				
				proxy.addProcess(process);	
			}
		}

		override public function addToRegistry(registry : IObjectRegistry) : void
		{
			super.addToRegistry(registry);
			
			if(!registry.hasNamed(_controllerName))
			{
				_controller.registry = registry;
				var p:IInstanceProxy = createInstanceProxy(_controllerName, IWiringController, InstanceProxy.SINGLETON, _controller);
				registry.registerProxy(p, _controllerName);
			}
		}
		
		public function get controller() : IWiringController
		{
			return _controller;
		}
	}
}
