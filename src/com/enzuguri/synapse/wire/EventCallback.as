package com.enzuguri.synapse.wire 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class EventCallback 
	{
		private var _type : String;
		private var _methodName : String;
		private var _translations : Array;
		private var _priority : int;
		private var _targetName:String;
		
		public function EventCallback(type:String, methodName:String, priority:int = 0, translations:Array = null) 
		{
			_priority = priority;
			_translations = translations;
			_methodName = methodName;
			_type = type;
		}
		
		public function resolveTarget(registry : IObjectRegistry) : Object
		{
			return registry.resolveNamed(_targetName);
		}

		
		
		public function dispose():void
		{
			_translations = null;
		}


		public function executeCallback(event : Event, target:Object) : Boolean
		{
			var params:Array = _translations ? translateEvent(event) : [event];
			var success:Boolean = true;
			try
			{
				(target[_methodName] as Function).apply(this, params);
			}
			catch(err:WireError)
			{
				success = false;
			}
			return success;
		}

		protected function translateEvent(event:Event):Array
		{
			var props:Array = [];
			var len:int = _translations.length;
			
			var propName:String;
			for (var i : int = 0;i < len; i++) 
			{
				propName = _translations[i];
				props[i] = event.hasOwnProperty(propName) ? event[propName] : null;	
			}
			
			return props;
		}

		public function get type() : String
		{
			return _type;
		}
		
		public function get priority() : int
		{
			return _priority;
		}
		
		public function get targetName() : String
		{
			return _targetName;
		}
		
		public function set targetName(value : String) : void
		{
			_targetName = value;
		}
		
		public function toString() : String 
		{
			var strout:String = "EventCallback\n{" + 
								"\n\ttype:" + _type + 
								"\n\tmethod:" + _methodName + 
								"\n\ttransaltions:" + _translations + 
								"\n\ttargetName:" + _targetName + 
								"\n\tpriority:" + _priority + 
								"\n}";
			
			return strout;
		}
	}
}
