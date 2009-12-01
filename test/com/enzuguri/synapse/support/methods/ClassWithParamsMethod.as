
package com.enzuguri.synapse.support.methods 
{

	import com.enzuguri.synapse.support.ClassInSameRegistry;
	import com.enzuguri.synapse.support.AnotherClass;
	/**
	 * @author Alex Fell
	 */
	public class ClassWithParamsMethod 
	{
		[Inject]
		public function callMethod(propA:AnotherClass, propB:ClassInSameRegistry):void
		{
			
		}
	}
}
