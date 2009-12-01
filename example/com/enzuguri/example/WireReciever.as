package com.enzuguri.example 
{

	import flash.events.Event;
	/**
	 * @author alex
	 */
	public class WireReciever 
	{
		[Wire(handle="complete")]
		public function handleComplete(event:Event):void
		{
			trace("horray I got the event", event);
		}
	}
}
