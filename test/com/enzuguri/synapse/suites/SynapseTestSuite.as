package com.enzuguri.synapse.suites
{

	import com.enzuguri.synapse.tests.MethodTests;
	import com.enzuguri.synapse.tests.ConstructorTests;
	import com.enzuguri.synapse.tests.RegistryTests;
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SynapseTestSuite
	{
		public var registryTests:RegistryTests;
		public var constructorTests:ConstructorTests;
		public var methodTests:MethodTests;
	}
}