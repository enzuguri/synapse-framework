package com.enzuguri.example.b 
{

	import com.enzuguri.example.support.command.SmarterEncodeTextCommand;
	import com.enzuguri.example.support.encode.ReallySimpleEncoder;
	import com.enzuguri.example.support.encode.IEncoder;
	import com.enzuguri.example.support.command.BuildViewCommand;
	import com.enzuguri.example.support.model.CredentialsModel;
	import com.enzuguri.example.support.components.TextInputPanel;
	import com.enzuguri.example.support.components.CredentialOutputPanel;
	import flash.display.Stage;
	/**
	 * @author alex
	 */
	public class ExampleBConfig 
	{
		//the stage
		public var stage:Stage;
		
		
		//view components
		public var output:CredentialOutputPanel;
		public var input:TextInputPanel;
		
		//model
		public var model:CredentialsModel;
		
		//commands
		[Inject(type="instance")]
		public var startup:BuildViewCommand;
		[Inject(type="instance")]
		public var encode:SmarterEncodeTextCommand;
		
		//utils
		public var encoder:IEncoder = new ReallySimpleEncoder();
		
		public function ExampleBConfig(defaultStage:Stage) 
		{
			stage = defaultStage;
		}
	}
}
