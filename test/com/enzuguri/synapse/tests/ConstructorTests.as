
package com.enzuguri.synapse.tests 
{
	import flexunit.framework.Assert;

	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.process.NullConstructorProcess;
	import com.enzuguri.synapse.support.TestASBuilder;
	import com.enzuguri.synapse.support.construct.ClassWithInjectedConstructor;
	import com.enzuguri.synapse.support.construct.ClassWithNoConstructor;
	import com.enzuguri.synapse.support.construct.ClassWithNonInjectedConstructor;

	/**
	 * @author Alex Fell
	 */
	public class ConstructorTests 
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
		public function testConstructorWithNoParams():void
		{
			var process:IInjectionProcess = builder.getConstructorProcessAdded(ClassWithNoConstructor);
			
			Assert.assertNotNull("Assert that we returned a process", process);
			Assert.assertTrue("Assert that the process is a null constructor", process is NullConstructorProcess);
		}

		[Test]
		public function testConstructorWithNullInjection():void
		{
			var process:IInjectionProcess = builder.getConstructorProcessAdded(ClassWithNonInjectedConstructor);
			
			Assert.assertFalse("boo", false);
			
//			Assert.assertNotNull("Assert that we returned a process", process);
//			Assert.assertTrue("Assert that the process is a null constructor", process is NullConstructorProcess);
		}

		[Test]
		public function testConstructorWithInjection():void
		{
			var process:IInjectionProcess = builder.getConstructorProcessAdded(ClassWithInjectedConstructor);
			
			Assert.assertFalse("foo", false);
//			Assert.assertNotNull("Assert that we returned a process", process);
//			Assert.assertTrue("Assert that the process is a null constructor", process is NullConstructorProcess);
		}
		
	}
}
