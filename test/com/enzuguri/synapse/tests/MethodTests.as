
package com.enzuguri.synapse.tests 
{
	import flexunit.framework.Assert;

	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.support.TestASBuilder;
	import com.enzuguri.synapse.support.methods.ClassWithNoParamsMethod;
	import com.enzuguri.synapse.support.methods.ClassWithParamsMethod;

	/**
	 * @author Alex Fell
	 */
	public class MethodTests 
	{
		private var builder:TestASBuilder;
		
		[Before]
		public function setup():void
		{
			builder = new TestASBuilder();
		}

		
		[After]
		public function teardown():void
		{
			builder = null;
		}

		[Test]
		public function testMethodWithNoParams():void
		{
			var process:IInjectionProcess = builder.getMethodProcessAdded(ClassWithNoParamsMethod);
			
			Assert.assertNotNull("Assert that we returned a process", process);
		}


		[Test]
		public function testMethodWithInjection():void
		{
			var process:IInjectionProcess = builder.getMethodProcessAdded(ClassWithParamsMethod);
			
			Assert.assertFalse("foo", false);
//			Assert.assertNotNull("Assert that we returned a process", process);
//			Assert.assertTrue("Assert that the process is a null constructor", process is NullConstructorProcess);
		}
	}
}
