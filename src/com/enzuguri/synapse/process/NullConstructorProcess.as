
package com.enzuguri.synapse.process 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class NullConstructorProcess 
		implements IInjectionProcess 
	{

		protected var _clazz:Class;
		
		
		
		public function NullConstructorProcess(clazz:Class) 
		{
			_clazz = clazz;
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			return new _clazz();
		}
		
		public function removeInjection(registry:IObjectRegistry, target : Object) : Object
		{
			return target;
		}
		
		
		
		public function dispose():void
		{
		}
	}
}
