
package com.enzuguri.synapse.process 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class MethodInjectionProcess 
		implements IInjectionProcess 
	{

		private var _methodName:String;
		
		private var _registryNames:Array;

		
		
		public function MethodInjectionProcess(methodName:String, registryNames:Array = null) 
		{
			
			_methodName = methodName;
			_registryNames = registryNames || [];
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			
			if(target)
			{
				try
				{
					var argArray:Array = [];
					var len:int = _registryNames.length;
					for (var i : int = 0; i < len; i++) 
					{
						argArray[i] = registry.retrieveNamed(_registryNames[i]);
					}
					
					(target[_methodName] as Function).apply(this, argArray);
				}
				catch(err:Error)
				{
					trace(err.getStackTrace());
				}
			}
			
			
			return target;
		}
		
		public function removeInjection(target : Object) : Object
		{
			return target;
		}
	}
}
