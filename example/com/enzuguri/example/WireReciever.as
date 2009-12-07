package com.enzuguri.example 
{

	import flash.events.Event;
	/**
	 * @author alex
	 */
	public class WireReciever 
	{
		
		
		
		
		[Wire(handle="complete", wake="true")]
		public function handleComplete(event:Event):void
		{
			trace("horray I got the event", event);
		}
		
		[Wire(handle="complete", order="3", translations="type,target")]
		public function handleChange(type:String, target:Object):void
		{
			trace("horray I got the event first", type, target);
		}
	}
}
