package com.enzuguri.example.support.encode 
{

	/**
	 * @author alex
	 */
	public class ReallySimpleEncoder 
		implements IEncoder 
	{
		public function encodeString(str : String) : String
		{
			return str;
		}
	}
}
