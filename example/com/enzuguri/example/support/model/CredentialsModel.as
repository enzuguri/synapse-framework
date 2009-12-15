package com.enzuguri.example.support.model 
{
	import com.enzuguri.example.support.events.CredentialEvent;

	import flash.events.EventDispatcher;

	/**
	 * @author alex
	 */
	[Wire(dispatch="credentialChanged")] 
	public class CredentialsModel 
		extends EventDispatcher 
	{
		
		private var _encodedString: String;
		
		public function get encodedString() : String
		{
			return _encodedString;
		}
		
		[Wire(handle="changeCredential", translations="encoded")]
		public function set encodedString(value : String) : void
		{
			if(!_encodedString || value != _encodedString)
			{
				_encodedString = value;
				dispatchEvent(new CredentialEvent(CredentialEvent.CREDENTIAL_CHANGED, _encodedString));
			}
		}
	}
}
