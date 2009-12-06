package com.enzuguri.example 
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author alex
	 */
	[Wire(dispatch="complete")]
	public class WiredDispatcher 
		extends Sprite 
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
