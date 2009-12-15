package com.enzuguri.example.support.events 
{
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class PanelEvent extends Event 
	{
		public var text : String;
		
		public static const SEND_TEXT:String = "sendText";
		
		public function PanelEvent(type : String, text:String = "")
		{
			this.text = text;
			super(type);
		}

		override public function clone() : Event
		{
			return new PanelEvent(type, text);
		}
	}
}
