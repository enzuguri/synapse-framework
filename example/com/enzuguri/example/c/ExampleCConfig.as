package com.enzuguri.example.c 
{
	import com.enzuguri.example.support.components.CustomPanel;
	import com.enzuguri.example.support.command.BuildViewCommand;
	import com.enzuguri.example.support.command.SmarterEncodeTextCommand;
	import com.enzuguri.example.support.components.CredentialOutputPanel;
	import com.enzuguri.example.support.components.TextInputPanel;
	import com.enzuguri.example.support.encode.IEncoder;
	import com.enzuguri.example.support.encode.ReallySimpleEncoder;
	import com.enzuguri.example.support.model.CredentialsModel;

	import flash.display.Stage;

	/**
	 * @author alex
	 */
	public class ExampleCConfig 
	{
		
		//the stage
		public var stage:Stage;
		
		
		//view components
		public var output:CredentialOutputPanel;
		public var input:TextInputPanel;
		
		
		//custom named panel
		[Inject(name="secondaryDisplay")]
		public var secondary:TextInputPanel;
		
		public var custom:CustomPanel;
		
		//model
		public var model:CredentialsModel;
		
		//commands
		[Inject(type="instance")]
		public var startup:BuildViewCommand;
		[Inject(type="instance")]
		public var encode:SmarterEncodeTextCommand;
		
		//utils
		public var encoder:IEncoder = new ReallySimpleEncoder();
		
		public function ExampleCConfig(defaultStage:Stage) 
		{
			stage = defaultStage;
		}
	}
}
