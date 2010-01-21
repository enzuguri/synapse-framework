
package com.enzuguri.synapse.registry 
{
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	import com.enzuguri.synapse.proxy.InstanceProxy;

	/**
	 * @author Alex Fell
	 */
	public class ObjectRegistry 
		implements IObjectRegistry 
	{

		protected var _nameHash:Dictionary;
		
		
		
		public function ObjectRegistry(autoAdd:Boolean = true) 
		{
			_nameHash = new Dictionary();
			if (autoAdd)
			{
				var name:String = getClassName(IObjectRegistry);
				_nameHash[name] = new InstanceProxy(name, IObjectRegistry, InstanceProxy.SINGLETON, this);
			}
		}

		public function resolveNamed(name:String, target:Object = null):*
		{
			var instance:IInstanceProxy = _nameHash[name];
			
			if(instance)
				return instance.resolve(this);
				
			return null;	
		}

		
		
		public function registerProxy(proxy:IInstanceProxy, name:String):void
		{
			_nameHash[name] = proxy;
		}
		
		
		
		public function resolveTyped(type:Class, instance:Object = null):*
		{
			return resolveNamed(getClassName(type), instance);
		}

		
		
		public function removeNamed(name : String, dispose:Boolean = true) : void
		{
			var proxy:IInstanceProxy = resolveNamed(name);
			if (proxy && dispose)
				proxy.dispose(this);
			delete _nameHash[name];	
		}

		public function removeTyped(type : Class, dispose:Boolean = true) : void
		{
			removeNamed(getClassName(type), dispose);
		}

		public function disposeInstance(instance : Object, remove : Boolean = false) : Boolean
		{
			var proxy:IInstanceProxy = getProxyFromInstance(instance);
			if(proxy)
			{
				proxy.disposeInstance(this, instance);
				if (remove)
					delete _nameHash[proxy.name];
				return true;	
			}
			return false;
		}
		
		protected function getClassName(value:Object):String
		{
			return getQualifiedClassName(value);
		}
		
		public function getProxyFromInstance(instance : Object) : IInstanceProxy
		{
			var proxy:IInstanceProxy = _nameHash[getClassName(instance)];
			
			if(!proxy)
			{
				var item:IInstanceProxy;
				for (var name : String in _nameHash) 
				{
					item = _nameHash[name];
					if (item.matchesInstance(instance))
					{
						proxy = item;
						break;
					}
				}
			}
			return proxy;
		}
		
		public function hasNamed(name : String) : Boolean
		{
			return _nameHash[name] != null;
		}
		
		public function hasTyped(type : Class) : Boolean
		{
			return hasNamed(getClassName(type));
		}
	}
}
