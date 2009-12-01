package com.enzuguri.synapse.registry.composite 
{
	import com.enzuguri.synapse.registry.IObjectRegistry;
	
	/**
	 * @author alex
	 */
	public interface ICompositeRegistry 
		extends IObjectRegistry 
	{
		function addReferenceRegistry(registry:IObjectRegistry):void;
		
		function removeReferenceRegistry(registry:IObjectRegistry):void;
		
		function listReferencedRegistries():Array;
		
		function clearReferencedRegistries():void;
	}
}
