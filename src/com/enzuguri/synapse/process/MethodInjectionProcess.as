
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
		
		private var _registryNames : Array;
	
		private var _order : int;

		
		
		public function MethodInjectionProcess(methodName:String, registryNames:Array = null, order:int = 0) 
		{
			_order = order;
			_methodName = methodName;
			_registryNames = registryNames || [];
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			if(target)
			{
				try
				{
					if(_registryNames.length == 0)
						(target[_methodName] as Function)();
					else
					{
						var argArray:Array = [];
						var len:int = _registryNames.length;
						for (var i : int = 0; i < len; i++) 
							argArray[i] = registry.resolveNamed(_registryNames[i]);
						
						(target[_methodName] as Function).apply(this, argArray);
					}
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
