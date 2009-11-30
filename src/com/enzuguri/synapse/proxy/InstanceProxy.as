
package com.enzuguri.synapse.proxy 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class InstanceProxy 
	{

		public static const SINGLETON:String = "singleton";
		
		private var _type:String;
		
		private var _instance:Object;
		
		private var _clazz:Class;

		private var _processList:Array;
		
		public function InstanceProxy(clazz:Class, type:String = SINGLETON) 
		{
			_processList = [];
			_clazz = clazz;
			_type = type;
		}

		
		
		public function resolve(registry:IObjectRegistry):*
		{
			if(_type == SINGLETON && _instance)
				return _instance;
			
			_instance = null;
			
			var len:int = _processList.length;	
			for (var i : int = 0;i < len; i++) 
			{
				_instance = (_processList[i] as IInjectionProcess).execute(registry, _instance);
			}
			
			return _instance;	
		}

		public function addProcess(process:IInjectionProcess):void
		{
			_processList[_processList.length] = process;
		}

		
		
		public function get type():String
		{
			return _type;
		}
		
		
		
		public function get clazz():Class
		{
			return _clazz;
		}
	}
}
