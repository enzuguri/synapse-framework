package com.enzuguri.example 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	
	/**
	 * @author alex
	 */
	[Wire(dispatch="complete")]
	public class WiredDispatcher 
		extends EventDispatcher 
	{
		public function WiredDispatcher()
		{
			super();
		}
		
		public function raiseCompleteEvent():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}
