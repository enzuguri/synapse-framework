package com.enzuguri.example.b 
{
	import com.enzuguri.example.support.events.ApplicationEvent;
	import com.enzuguri.synapse.registry.ObjectRegistry;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.builder.metadata.MetaDataBuilder;
	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class ExampleB 
		extends Sprite 
	{
		public function ExampleB()
		{
			var config:ExampleBConfig = new ExampleBConfig(stage);
			var registry:IObjectRegistry = new ObjectRegistry();
			
			var builder:MetaDataBuilder = new MetaDataBuilder();
			
			builder.buildIntoRegistry(registry, config);
			builder.controller.dispatchEvent(new ApplicationEvent(ApplicationEvent.STARTUP));
		}
	}
}
