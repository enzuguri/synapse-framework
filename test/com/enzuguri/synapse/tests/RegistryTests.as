
package com.enzuguri.synapse.tests 
{

	import flexunit.framework.Assert;
	import com.enzuguri.synapse.support.ClassInSameRegistry;
	import com.enzuguri.synapse.support.ClassWithParentDependency;
	import com.enzuguri.synapse.registry.composite.CompositeRegistry;
	import com.enzuguri.synapse.support.ClassInParentRegistry;
	import com.enzuguri.synapse.builder.asmetadata.ASMetaDataBuilder;
	import com.enzuguri.synapse.registry.ObjectRegistry;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	/**
	 * @author Alex Fell
	 */
	public class RegistryTests 
	{

		private var builder:ASMetaDataBuilder;
		
		[Before]
		public function setup():void
		{
			builder = new ASMetaDataBuilder();
		}

		
		[After]
		public function teardown():void
		{
			builder = null;
		}

		[Test]
		public function testCompositeRegistry():void
		{
			var parentRegistry:IObjectRegistry = new ObjectRegistry();
			builder.buildWithClass(parentRegistry, ClassInParentRegistry);
			
			
			
			var localRegistry:CompositeRegistry = new CompositeRegistry();
			localRegistry.addReferenceRegistry(parentRegistry);
			
			builder.buildWithClass(localRegistry, ClassInSameRegistry);
			builder.buildWithClass(localRegistry, ClassWithParentDependency);
			
			
			var instance:ClassWithParentDependency = localRegistry.resolveTyped(ClassWithParentDependency);
			
			Assert.assertNotNull("Assert instance is created without error", instance);
			Assert.assertNotNull("Asset parent property has been set", instance.parentDependency);
			Assert.assertTrue("Asset parent property is the correct type", instance.parentDependency is ClassInParentRegistry);
		}
	}
}
