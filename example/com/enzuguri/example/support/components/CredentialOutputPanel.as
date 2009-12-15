package com.enzuguri.example.support.components 
{
	import flash.text.TextField;
	import com.enzuguri.example.support.events.CredentialEvent;
	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class CredentialOutputPanel 
		extends Sprite 
	{
		private var field : TextField;
		
		public function CredentialOutputPanel()
		{
			init();
		}
		
		private function init() : void
		{
			field = new TextField();
			addChild(field);
		}

		[Wire(handle="credentialChanged")]
		public function onCredentialChange(event:CredentialEvent):void
		{
			field.text = event.encoded;
		}
	}
}
