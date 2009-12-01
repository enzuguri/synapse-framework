
package com.enzuguri.synapse.support.construct 
{
	import com.enzuguri.synapse.support.AnotherClass;
	import com.enzuguri.synapse.support.ClassInSameRegistry;

	/**
	 * @author Alex Fell
	 */
	public class ClassWithInjectedConstructor 
	{
		[Inject(id="face,book,please")]
		public function ClassWithInjectedConstructor(propA:ClassInSameRegistry, propB:AnotherClass) 
		{
			
		}
	}
}
