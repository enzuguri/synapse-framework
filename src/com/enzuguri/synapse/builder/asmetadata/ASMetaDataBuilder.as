
package com.enzuguri.synapse.builder.asmetadata 
{
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.process.MethodInjectionProcess;
	import com.enzuguri.synapse.process.PropertyInjectionProcess;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.process.NullConstructorProcess;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.builder.IRegistryBuilder;
	import com.enzuguri.synapse.registry.IObjectRegistry;

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
			
			var len:int = params.length;
			for (var i : int = 0; i < len; i++) 
			{
				var config:Object = params[i];
				parseConfig(config);
			}
		}
		
		protected function parseConfig(config : Object) : void
		{
			var description:XML = describeType(config);
		}

		
		public function buildWithClass(registry:IObjectRegistry, clazz:Class, name:Object = null, 
			type:String = InstanceProxy.SINGLETON):void
		{
			
			if(name is Class)
				name = getClassName(name as Class);
			else if(!name)
				name = getClassName(clazz);
			
			trace("clazz registered under", name);
				
			var proxy:IInstanceProxy = createInstanceProxy(name as String, clazz, type);
			proxy = processInjections(clazz, proxy);		
			registry.registerProxy(proxy, proxy.name);
		}
		
		
		
		protected function processInjections(clazz:Class, proxy:IInstanceProxy):IInstanceProxy
		{
			var description:XML = describeType(clazz);
			
			determineConstructor(description, clazz, proxy);
			determineVariables(description, proxy);
			determineMethods(description, proxy);
			
			return postProcess(description, proxy);
		}

		protected function postProcess(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			return proxy;
		}

		
		
		protected function determineMethods(description:XML, proxy:IInstanceProxy):void
		{
			for each (var node:XML in description.factory.method.metadata.(@name == MetaDataType.INJECT))
			{
				proxy.addProcess(createMethodProcess(node));
			}
		}
		
		
		
		protected function determineVariables(description:XML, proxy:IInstanceProxy):void
		{
			for each (var node:XML in description.factory.*.
				(name() == MetaDataType.VARIABLE || name() == MetaDataType.ACCESSOR).metadata.(@name == MetaDataType.INJECT))
			{
				proxy.addProcess(createPropertyProcess(node));
			}
		}
		
		
		protected function createMethodProcess(node:XML):IInjectionProcess
		{
			trace("debug method", node);
			var methodName:String;
			var registryNames:Array = [];
			return new MethodInjectionProcess(methodName, registryNames);
		}

		
		
		private function createPropertyProcess(node:XML):IInjectionProcess
		{
			var propertyName:String = node.parent().@name.toString();
			var registryName:String = node.parent().@type.toString();
			
			if (node.hasOwnProperty('arg') && node.arg.(@key == 'name').length)
				registryName = node.arg.@value.toString();
				
			trace("debug prop", propertyName, registryName);
			return new PropertyInjectionProcess(propertyName, registryName);
		}

		
		
		private function determineConstructor(description:XML, clazz:Class, proxy:IInstanceProxy):void
		{
			var node:XML = description.factory.constructor[0];
			if (node)
			{
//				proxy.addProcess(process)
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
