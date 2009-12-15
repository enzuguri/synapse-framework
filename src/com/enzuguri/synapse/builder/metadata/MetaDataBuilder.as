package com.enzuguri.synapse.builder.metadata 
{
	import com.enzuguri.synapse.builder.IRegistryBuilder;
	import com.enzuguri.synapse.parser.IInjectionParser;
	import com.enzuguri.synapse.parser.metadata.MetaDataParser;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.wire.IWiringController;
	import com.enzuguri.synapse.wire.WiringController;
	import com.enzuguri.synapse.wire.process.InjectCallbackProcess;

	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author alex
	 */
	public class MetaDataBuilder 
		implements IRegistryBuilder 
	{
		protected var _autoAdd : Boolean;

		protected var _parser : IInjectionParser;

		protected var _controller : IWiringController;

		protected var _controllerName : String;




		public function MetaDataBuilder(autoAdd : Boolean = true, controllerName : String = "")
		{
			_controllerName = controllerName != "" ? controllerName : getClassName(IWiringController);
			_controller = new WiringController(); 
			_autoAdd = autoAdd;
			_parser = new MetaDataParser();
		}

		public function buildIntoRegistry(registry : IObjectRegistry, ...params) : void
		{
			addToRegistry(registry);
			
			var len : int = (params as Array).length;
			for (var i : int = 0;i < len;i++) 
			{
				var config : Object = params[i];
				parseConfig(registry, config);
			}
		}

		protected function parseConfig(registry : IObjectRegistry, config : Object) : void
		{
			var description : XML = describeType(config.constructor);
			
			for each (var node:XML in description.factory.*.(name() == "variable" || name() == "accessor"))
			{
				var propertyName : String = String(node.@name);
				var type : String = String(node.@type);
				var lifecycle:String = "singleton";
				var regName:Object = null;
				
				for each (var meta : XML in node.metadata.(@name == "Inject").arg) 
				{
					if(meta.@key == "name")
						regName = String(meta.@value);
					else if(meta.@key == "type")
						lifecycle = String(meta.@value);	
				}
				
				//trace("stuff", lifecycle, regName, propertyName);
				
				if (config[propertyName])
					buildWithValue(registry, config[propertyName], regName || type);
				else
					buildWithClass(registry, getDefinitionByName(type) as Class, regName || type, lifecycle);
			}
		}

		
		public function buildWithClass(registry : IObjectRegistry, clazz : Class, name : Object = null, 
			type : String = "singleton") : void
		{
			
			if(name is Class)
				name = getClassName(name as Class);
			else if(!name)
				name = getClassName(clazz);
			
			var proxy : IInstanceProxy = createInstanceProxy(name as String, clazz, type);
			processInjections(clazz, proxy);		
			registry.registerProxy(proxy, proxy.name);
		}

		public function buildWithValue(registry : IObjectRegistry, value : Object, name : Object = null) : void
		{
			var clazz : Class = value.constructor as Class;
			
			if(name is Class)
				name = getClassName(name as Class);
			else if(!name)
				name = getClassName(clazz);
			
			var proxy : IInstanceProxy = createInstanceProxy(name as String, clazz, "singleton", value);
			processInjections(value, proxy);		
			registry.registerProxy(proxy, proxy.name);
		}

		
		
		protected function processInjections(target : Object, proxy : IInstanceProxy) : void
		{
			var processes : Array = _parser.determineInjectionProcesses(target, _controllerName);
			
			var length : int = processes.length;
			var item : IInjectionProcess;
			for (var i : int = 0;i < length;i++) 
			{
				item = processes[i];
				proxy.addProcess(item);
				if(item is InjectCallbackProcess)
				{
					var process : InjectCallbackProcess = item as InjectCallbackProcess;
					process.callback.targetName = proxy.name;
					if(process.wake)
						_controller.registerCallback(process.callback);
				}
			}
		}

		protected function createInstanceProxy(name : String, clazz : Class, type : String, 
			instance : Object = null) : IInstanceProxy
		{
			return new InstanceProxy(name, clazz, type, instance);
		}

		
		
		protected function getClassName(clazz : Class) : String
		{
			return getQualifiedClassName(clazz);
		}

		public function addToRegistry(registry : IObjectRegistry) : void
		{
			if (!registry.hasTyped(IRegistryBuilder))
			{
				var name : String = getClassName(IRegistryBuilder);
				var proxy : IInstanceProxy = createInstanceProxy(name, IRegistryBuilder, InstanceProxy.SINGLETON, this);
				registry.registerProxy(proxy, name);
			}
			
			if(!registry.hasNamed(_controllerName))
			{
				_controller.registry = registry;
				var p : IInstanceProxy = createInstanceProxy(_controllerName, IWiringController, InstanceProxy.SINGLETON, _controller);
				registry.registerProxy(p, _controllerName);
			}
		}

		public function get controller() : IWiringController
		{
			return _controller;
		}
	}
}
