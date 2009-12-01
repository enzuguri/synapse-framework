
package com.enzuguri.synapse.support 
{

	/**
	 * @author Alex Fell
	 */
	public class ClassWithParentDependency 
		extends NumberGeneratorClass
	{
		
		[Inject]
		public var parentDependency:ClassInParentRegistry;
		
		
		[Inject]
		public var localDependency:ClassInSameRegistry;
		
	}
}
