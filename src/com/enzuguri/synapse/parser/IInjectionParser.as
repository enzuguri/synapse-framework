package com.enzuguri.synapse.parser 
{

	/**
	 * @author alex
	 */
	public interface IInjectionParser 
	{
		function determineInjectionProcesses(description : Object, controllerReference:String) : Array;
	}
}
