package com.enzuguri.example.support.command 
{

	import com.enzuguri.example.support.model.CredentialsModel;
	import com.enzuguri.example.support.components.TextInputPanel;
	import com.enzuguri.example.support.encode.ReallySimpleEncoder;
	import com.enzuguri.example.support.events.PanelEvent;
	/**
	 * @author alex
	 */
	public class EncodeTextCommand 
	{
		
		[Wire(handle="sendText")]
		public function encodeText(event:PanelEvent):void
		{
			var text:String = panel.text;
			var result:String = encoder.encodeString(text);
			model.encodedString = result;
		}

		[Inject]
		public var encoder:ReallySimpleEncoder;
		
		[Inject]
		public var panel:TextInputPanel;

		[Inject]
		public var model:CredentialsModel;
		
	}
}
