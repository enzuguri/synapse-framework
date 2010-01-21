package com.enzuguri.synapse.parser 
{

	
	
	/**
	 * An IInjectionParser processes a given configuration and returns an ordered list of <code>IInjectionProcess</code>
	 * instances.
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface IInjectionParser 
	{
		/**
		 * Given a config, a list of <code>IInjectionProcess</code> instances are determined and returned in an 
		 * order ready for insertion into an <code>IInjectionProxy</code> instance. The 'controllerReference'
		 * parameter is given for any configurations that require it.
		 */
		function determineInjectionProcesses(config : Object, controllerReference : String) : Array;
	}
}
