package com.enzuguri.example.c 
{
	import com.enzuguri.example.support.events.ApplicationEvent;
	import com.enzuguri.synapse.builder.metadata.MetaDataBuilder;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.registry.ObjectRegistry;

	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class ExampleC extends Sprite 
	{
		public function ExampleC()
		{
			var config:ExampleCConfig = new ExampleCConfig(stage);
			var registry:IObjectRegistry = new ObjectRegistry();
			
			var builder:MetaDataBuilder = new MetaDataBuilder();
			
			builder.buildIntoRegistry(registry, config);
			builder.controller.dispatchEvent(new ApplicationEvent(ApplicationEvent.STARTUP));
		}
	}
}
