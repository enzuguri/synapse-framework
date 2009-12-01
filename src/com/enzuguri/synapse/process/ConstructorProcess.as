
package com.enzuguri.synapse.process 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class ConstructorProcess 
		extends NullConstructorProcess
	{
		
		
		override public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			// TODO: Auto-generated method stub
			return super.applyInjection(registry, target);
		}
	}
}
