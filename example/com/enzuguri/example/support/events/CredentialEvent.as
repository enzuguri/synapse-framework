package com.enzuguri.example.support.events 
{
	import flash.events.Event;

	/**
	 * @author alex
	 */
	public class CredentialEvent 
		extends Event 
	{
		public static const CREDENTIAL_CHANGED : String = "credentialChanged";
		public static const CHANGE_CREDENTIAL : String = "changeCredential";



		public var encoded : String;

		public function CredentialEvent(type : String, encoded:String = "")
		{
			this.encoded = encoded;
			super(type);
		}

		override public function clone() : Event
		{
			return new CredentialEvent(type, encoded);
		}
	}
}
