
package com.enzuguri.synapse.support 
{
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import flash.utils.describeType;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.builder.asmetadata.ASMetaDataBuilder;

	/**
	 * @author Alex Fell
	 */
	public class TestASBuilder 
		extends ASMetaDataBuilder 
	{
		public function TestASBuilder(autoAdd:Boolean = true)
		{
			super(autoAdd);
		}
		
		public function getConstructorProcessAdded(clazz:Class):IInjectionProcess
		{
			var proxy:IInstanceProxy = createInstanceProxy("test", clazz, InstanceProxy.SINGLETON);
			
			var description:XML = describeType(clazz);
			
			determineConstructor(description, clazz, proxy);
			
			return proxy.processList[0];
		}
		
		public function getMethodProcessAdded(clazz:Class):IInjectionProcess
		{
			var proxy:IInstanceProxy = createInstanceProxy("test", clazz, InstanceProxy.SINGLETON);
			
			var description:XML = describeType(clazz);
			
			determineMethods(description, proxy);
			
			return proxy.processList[0];
		}
	}
}
