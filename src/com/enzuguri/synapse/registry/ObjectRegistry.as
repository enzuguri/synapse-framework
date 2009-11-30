
package com.enzuguri.synapse.registry 
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	import com.enzuguri.synapse.proxy.InstanceProxy;

	/**
	 * @author Alex Fell
	 */
	public class ObjectRegistry 
		implements IObjectRegistry 
	{

		private var _nameHash:Dictionary;
		
		
		
		public function ObjectRegistry() 
		{
			_nameHash = new Dictionary();
		}
		
		public function retrieveNamed(name:String):*
		{
			var instance:InstanceProxy = _nameHash[name];
			
			if(instance)
				return instance.resolve(this);
				
			return null;	
		}

		
		
		public function registerInstance(instance:InstanceProxy, name:String):void
		{
			_nameHash[name] = instance;
		}
		
		
		
		public function retrieveTyped(type:Class):*
		{
			return retrieveNamed(getQualifiedClassName(type));
		}
	}
}
