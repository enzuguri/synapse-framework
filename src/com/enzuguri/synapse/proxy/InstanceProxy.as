
package com.enzuguri.synapse.proxy 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class InstanceProxy
		implements IInstanceProxy 
	{

		public static const SINGLETON:String = "singleton";
		
		private var _type:String;
		
		private var _instance:Object;
		
		private var _clazz:Class;

		private var _processList : Array;
		private var _name : String;
	
		private var _processed : Boolean;

		public function InstanceProxy(name:String, clazz:Class, type:String = SINGLETON, instance:Object = null) 
		{
			_instance = instance;
			_name = name;
			_processList = [];
			_clazz = clazz;
			_type = type;
		}
		
		public function matchesInstance(instance : Object) : Boolean
		{
			return (instance is _clazz);
		}

		
		
		public function resolve(registry:IObjectRegistry):*
		{
			if (_instance && processed)
				return _instance;
			
			var output:Object = create(registry);
			
			if (_type == SINGLETON)
				_instance = output;
			
			return output;	
		}
		
		protected function create(registry : IObjectRegistry) : Object
		{
			var output:Object = _type == SINGLETON ? _instance : null;
			
			// Set this here for looped references
			_processed = true;			
			
			var len:int = _processList.length;	
			for (var i : int = 0;i < len; i++) 
			{
				output = (_processList[i] as IInjectionProcess).applyInjection(registry, output);
			}
			
			return output;
		}

		public function disposeInstance(registry:IObjectRegistry, instance:Object = null):void
		{
			instance = instance || _instance;
			
			if(instance)
			{
				var i : int = _processList.length;
				while(i--)
				{
					instance = (_processList[i] as IInjectionProcess).removeInjection(registry, instance);	
				}
				// If a singleton, this should remove it
				if (instance == _instance)
					_instance = null;
			}
		}

		public function addProcess(process:IInjectionProcess):void
		{
			if (process)
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
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get currentInstance() : Object
		{
			return _instance;
		}
		
		
		
		public function dispose(registry:IObjectRegistry):void
		{
			disposeInstance(registry);
			
			var i:int = _processList.length;
			while(i--)
			{
				(_processList[i] as IInjectionProcess).dispose();
			}
			
			_processList.length = 0;
			_clazz = null;
		}
		
		public function get processList():Array
		{
			return _processList;
		}
		
		public function toString() : String 
		{
			var strout:String = "InstanceProxy\n{" +
								"\n\ttype:" + _type +
								"\n\tname:" + name +
								"\n\tclass:" + _clazz +
								"\n\tprocessList:" + _processList.join(", ") + 
								"\n\tinstance:" + _instance +  
								"\n}";	
			return strout;
		}
		
		public function get processed() : Boolean
		{
			return _processed;
		}
	}
}
