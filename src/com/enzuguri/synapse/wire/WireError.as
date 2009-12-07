package com.enzuguri.synapse.wire 
{

	/**
	 * @author alex
	 */
	public class WireError 
		extends Error 
	{
		public function WireError(reason:String = "pre-processed event")
		{
			super(reason, 0);
		}
	}
}
