package com.enzuguri.synapse.wire 
{
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class EventCallback 
	{
		private var _types : Array;
		private var _methodName : String;
		private var _translations : Array;

		public function EventCallback(types:Array, methodName:String, translations:Array = null) 
		{
			_translations = translations;
			_methodName = methodName;
			_types = types;
		}
		
		public function isTriggeredBy(event : Event) : Boolean
		{
			return _types.indexOf(event.type) > -1;
		}

		public function executeCallback(event : Event, target:Object) : void
		{
			var params:Array = _translations ? translateEvent(event) : [event];
			(target[_methodName] as Function).apply(this, params);
		}
		
		protected function translateEvent(event:Event):Array
		{
			return null;
		}
		
		public function get types() : Array
		{
			return _types;
		}
	}
}
