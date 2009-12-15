package com.enzuguri.example.a 
{
	import com.enzuguri.example.support.model.CredentialsModel;
	import com.enzuguri.example.support.events.ApplicationEvent;
	import com.enzuguri.example.support.command.EncodeTextCommand;
	import com.enzuguri.example.support.command.BuildViewCommand;
	import com.enzuguri.example.support.encode.ReallySimpleEncoder;
	import com.enzuguri.example.support.components.CredentialOutputPanel;
	import com.enzuguri.example.support.components.TextInputPanel;
	import com.enzuguri.synapse.registry.ObjectRegistry;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.builder.metadata.MetaDataBuilder;
	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class ExampleA 
		extends Sprite 
	{
		public function ExampleA()
		{
			var registry:IObjectRegistry = new ObjectRegistry();
			var builder:MetaDataBuilder = new MetaDataBuilder();
			builder.addToRegistry(registry);
			
			builder.buildWithValue(registry, stage);
			
			builder.buildWithClass(registry, BuildViewCommand, null, "instance");
			builder.buildWithClass(registry, EncodeTextCommand, null, "instance");
			
			builder.buildWithClass(registry, CredentialsModel);
			builder.buildWithClass(registry, TextInputPanel);
			builder.buildWithClass(registry, CredentialOutputPanel);
			builder.buildWithClass(registry, ReallySimpleEncoder);
			
			builder.controller.dispatchEvent(new ApplicationEvent(ApplicationEvent.STARTUP));
		}
	}
}
