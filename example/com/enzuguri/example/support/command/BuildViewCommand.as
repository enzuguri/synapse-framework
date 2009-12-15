package com.enzuguri.example.support.command 
{

	import com.enzuguri.example.support.components.TextInputPanel;
	import com.enzuguri.example.support.components.CredentialOutputPanel;
	import flash.display.Stage;
	import com.enzuguri.example.support.events.ApplicationEvent;
	/**
	 * @author alex
	 */
	public class BuildViewCommand 
	{
		[Wire(handle="startup")]
		public function startup(event:ApplicationEvent):void
		{
			inputPanel.x = 20;
			inputPanel.y = 20;
			
			outputPanel.x = 300;
			outputPanel.y = 20;
			
			stage.addChild(outputPanel);
			stage.addChild(inputPanel);
		}

		[Inject]
		public var stage:Stage;
		
		[Inject]
		public var outputPanel:CredentialOutputPanel;
		
		[Inject]
		public var inputPanel:TextInputPanel;
	}
}
