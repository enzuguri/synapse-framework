
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
		
		private var _registryName:String;

		
		
		public function PropertyInjectionProcess(propertyName:String, registryName:String) 
		{
			
			_registryName = registryName;
			_propertyName = propertyName;
		}

		
		
		public function execute(registry:IObjectRegistry, target:Object):Object
		{
			
			if(target)
			{
				try
				{
					target[_propertyName] = registry.retrieveNamed(_registryName);
				}
				catch(err:Error)
				{
					trace(err.getStackTrace());
				}
			}
			
			return target;
		}
	}
}
