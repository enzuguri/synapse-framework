package com.enzuguri.example.support.components 
{
	import com.enzuguri.example.support.events.ApplicationEvent;
	import com.enzuguri.example.support.events.CredentialEvent;
	import flash.display.Stage;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.wire.IWiringController;
	import flash.display.Sprite;

	/**
	 * @author alex
	 */
	public class CustomPanel 
		extends Sprite 
	{
		
		[Inject(name="secondaryDisplay")]
		public var panel:TextInputPanel;
		
		
		
		public function CustomPanel()
		{
		}
		
		[Wire(handle="startup")]
		public function startup(event:ApplicationEvent):void
		{
			
		}
		
		[Inject(order="1")]
		public function setupStage(registry:IObjectRegistry):void
		{
			trace("1. setup the stage");
			var stageRef:Stage = registry.resolveTyped(Stage);
			stageRef.addChild(this);
		}
		
		[Inject(order="2")]
		public function addPanel():void
		{
			trace("2. add the panel");
			panel.x = 300;
			panel.y = 300;
			addChild(panel);
		}
		
		[Inject(name="missingInjectee,com.enzuguri.synapse.wire::IWiringController", order="3")]
		public function setupController(randomObject:Object, controller:IWiringController):void
		{
			randomObject;
			controller.addEventListener(CredentialEvent.CREDENTIAL_CHANGED, credentialChangeHandler);
		}
		
		private function credentialChangeHandler(event : CredentialEvent) : void
		{
			panel.text = event.encoded;
		}
	}
}
