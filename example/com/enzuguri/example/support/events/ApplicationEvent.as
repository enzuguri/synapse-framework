package com.enzuguri.example.support.events 
{
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class ApplicationEvent 
		extends Event 
	{
		public static const STARTUP:String = "startup";
		
		public function ApplicationEvent(type : String)
		{
			super(type);
		}

		
		override public function clone() : Event
		{
			return new ApplicationEvent(type);
		}
	}
}
