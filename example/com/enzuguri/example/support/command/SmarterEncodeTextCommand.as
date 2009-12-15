package com.enzuguri.example.support.command 
{

	import com.enzuguri.example.support.events.CredentialEvent;
	import flash.events.EventDispatcher;
	import com.enzuguri.example.support.encode.IEncoder;
	/**
	 * @author alex
	 */
	
	[Wire(dispatch="changeCredential")]
	public class SmarterEncodeTextCommand
		extends EventDispatcher 
	{
		
		[Wire(handle="sendText", translations="text")]
		public function encodeText(text:String):void
		{
			var result:String = encoder.encodeString(text);
			dispatchEvent(new CredentialEvent(CredentialEvent.CHANGE_CREDENTIAL, result));
		}

		[Inject]
		public var encoder:IEncoder;
	}
}
