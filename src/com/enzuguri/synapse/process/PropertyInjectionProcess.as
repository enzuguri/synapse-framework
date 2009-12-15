
package com.enzuguri.synapse.process 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class PropertyInjectionProcess 
		implements IInjectionProcess 
	{

		private var _propertyName:String;
		
		private var _registryName: String;
		private var _order : int;

		
		
		public function PropertyInjectionProcess(propertyName:String, registryName:String, order:int = 0) 
		{
			_order = order;
			_registryName = registryName;
			_propertyName = propertyName;
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			if(target)
			{
				try
				{
					target[_propertyName] = registry.resolveNamed(_registryName);
				}
				catch(err:Error)
				{
					trace(err.getStackTrace());
				}
			}
			
			return target;
		}
		
		public function removeInjection(registry:IObjectRegistry, target : Object) : Object
		{
			if(target)
			{
				try
				{
					target[_propertyName] = null;
				}
				catch(err:Error)
				{
					
				}
			}
			return target;
		}
		
		
		
		public function dispose():void
		{
		}
		
		public function get order() : int
		{
			return _order;
		}
	}
}
