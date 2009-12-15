package com.enzuguri.synapse.parser 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.process.MethodInjectionProcess;
	import com.enzuguri.synapse.process.NullConstructorProcess;
	import com.enzuguri.synapse.process.PropertyInjectionProcess;
	import com.enzuguri.synapse.wire.EventCallback;
	import com.enzuguri.synapse.wire.process.InjectCallbackProcess;
	import com.enzuguri.synapse.wire.process.WatchWireProcess;

	/**
	 * @author alex
	 */
	public class ProcessParserBase 
		implements IInjectionParser 
	{
		protected function createWatchProcess(types : Array, controllerName : String = "") : IInjectionProcess
		{
			return new WatchWireProcess(types, controllerName);
		}
		
		protected function createEventCallbackProcess(callback : EventCallback, autoWake : Boolean, controllerName : String) : InjectCallbackProcess
		{
			return new InjectCallbackProcess(callback, autoWake, controllerName);
		}
		
		protected function createNullConstructor(clazz : Class) : IInjectionProcess
		{
			return new NullConstructorProcess(clazz);
		}
		
		protected function createPropertyProcess(propertyName : String, registryName : String) : IInjectionProcess
		{
			return new PropertyInjectionProcess(propertyName, registryName);
		}
		
		public function determineInjectionProcesses(description : Object, controllerReference:String) : Array
		{
			// TODO: Auto-generated method stub
			return null;
		}
		
		protected function createMethodProcess(methodName : String, registryNames : Array = null, order:int = 0) : IInjectionProcess
		{
			return new MethodInjectionProcess(methodName, registryNames, order);
		}
	}
}
