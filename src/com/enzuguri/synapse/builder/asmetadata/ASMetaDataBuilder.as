
package com.enzuguri.synapse.builder.asmetadata 
{
	import com.enzuguri.synapse.builder.IRegistryBuilder;
	import com.enzuguri.synapse.process.MethodInjectionProcess;
	import com.enzuguri.synapse.process.NullConstructorProcess;
	import com.enzuguri.synapse.process.PropertyInjectionProcess;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Alex Fell
	 */
	public class ASMetaDataBuilder 
		implements IRegistryBuilder 
	{
		protected var _autoAdd : Boolean;
		
		public function ASMetaDataBuilder(autoAdd:Boolean = true) 
		{
			_autoAdd = autoAdd;
		}

		public function buildIntoRegistry(registry:IObjectRegistry, ...params):void
		{
			addToRegistry(registry);
			
			var len:int = (params as Array).length;
			for (var i : int = 0; i < len; i++) 
			{
				var config:Object = params[i];
				parseConfig(registry, config);
			}
		}
		
		protected function parseConfig(registry:IObjectRegistry, config : Object) : void
		{
			var description:XML = describeType(config.constructor);
			
			for each (var node:XML in description.factory.*.(name() == "variable" || name() == "accessor"))
			{
				var propertyName:String = String(node.@name);
				var type:String = String(node.@type);
				
				if (config[propertyName])
					buildWithValue(registry, config[propertyName], type);
				else
					buildWithClass(registry, getDefinitionByName(type) as Class);
			}
		}

		
		public function buildWithClass(registry:IObjectRegistry, clazz:Class, name:Object = null, 
			type:String = "singleton"):void
		{
			
			if(name is Class)
				name = getClassName(name as Class);
			else if(!name)
				name = getClassName(clazz);
			
			var proxy:IInstanceProxy = createInstanceProxy(name as String, clazz, type);
			proxy = processInjections(clazz, proxy);		
			registry.registerProxy(proxy, proxy.name);
		}

		public function buildWithValue(registry:IObjectRegistry, value:Object, name:Object = null):void
		{
			var clazz:Class = value.constructor as Class;
			
			if(name is Class)
				name = getClassName(name as Class);
			else if(!name)
				name = getClassName(clazz);
			
			var proxy:IInstanceProxy = createInstanceProxy(name as String, clazz, "singleton", value);
			proxy = processInjections(value, proxy);		
			registry.registerProxy(proxy, proxy.name);
		}
		
		
		
		protected function getRealConstrcutorXML(clazz:Class, length:int):XML
		{
			trace("contructor length", length);
			var object:Object;
			try
			{
				switch (length)
				{
					case 0 : (object = new clazz());break;
					case 1 : (object = new clazz(null)); break;
					case 2 : (object = new clazz(null, null)); break;
					case 3 : (object = new clazz(null, null, null)); break;
					case 4 : (object = new clazz(null, null, null, null)); break;
					case 5 : (object = new clazz(null, null, null, null, null)); break;
					case 6 : (object = new clazz(null, null, null, null, null, null)); break;
					case 7 : (object = new clazz(null, null, null, null, null, null, null)); break;
					case 8 : (object = new clazz(null, null, null, null, null, null, null, null)); break;
					case 9 : (object = new clazz(null, null, null, null, null, null, null, null, null)); break;
					case 10 : (object = new clazz(null, null, null, null, null, null, null, null, null, null)); break;
				}
			}
			catch (error : Error)
			{
				trace(error);
			}
			
			return describeType(clazz);
		}

		
		
		protected function processInjections(target:Object, proxy:IInstanceProxy):IInstanceProxy
		{
			var description:XML;
			
			if(target is Class)
			{
				description = describeType(target);
				determineConstructor(description, target as Class, proxy);
			}
			else
				description = describeType(target.constructor);
			
			determineVariables(description, proxy);
			determineMethods(description, proxy);
			
			return postProcess(description, proxy);
		}

		protected function postProcess(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			// Keep FDT Happy
			description;
			return proxy;
		}

		
		
		protected function determineMethods(description:XML, proxy:IInstanceProxy):void
		{
			for each (var node:XML in description.factory.method.metadata.(@name == "Inject"))
			{
				var methodName:String = node.parent().@name.toString();
				var registryNames:Array = [];
				
				var index:int = 0; 
				for each (var parameter : XML in node.parent().parameter)
				{
					registryNames[index] = parameter.@type.toString();
					index++;
				}
				
				proxy.addProcess(new MethodInjectionProcess(methodName, registryNames));
			}
		}
		
		
		
		protected function determineVariables(description:XML, proxy:IInstanceProxy):void
		{
			
			for each (var node:XML in description.factory.*.
				(name() == "variable" || name() == "accessor").metadata.(@name == "Inject"))
			{
				var propertyName:String = node.parent().@name.toString();
				var registryName:String = node.parent().@type.toString();
			
				if (node.hasOwnProperty('arg') && node.arg.(@key == 'name').length)
					registryName = node.arg.@value.toString();
				
				proxy.addProcess(new PropertyInjectionProcess(propertyName, registryName));
			}
		}
		
		
		
		protected function determineConstructor(description:XML, clazz:Class, proxy:IInstanceProxy):void
		{
			var node:XML = description.factory.constructor[0];
			if (node)
			{
				var xmk:XML = getRealConstrcutorXML(clazz, node.children().length());
			}
			else
			{
				proxy.addProcess(new NullConstructorProcess(clazz));
			}
		}

		
		
		protected function createInstanceProxy(name:String, clazz:Class, type:String, 
			instance:Object = null):IInstanceProxy
		{
			return new InstanceProxy(name, clazz, type, instance);
		}

		
		
		protected function getClassName(clazz:Class):String
		{
			return getQualifiedClassName(clazz);
		}
		
		public function addToRegistry(registry : IObjectRegistry) : void
		{
			if (!registry.hasTyped(IRegistryBuilder))
			{
				var name:String = getClassName(IRegistryBuilder);
				var proxy:IInstanceProxy = createInstanceProxy(name, IRegistryBuilder, InstanceProxy.SINGLETON, this);
				registry.registerProxy(proxy, name);
			}
		}
	}
}
