package com.enzuguri.example 
{

	/**
	 * @author alex
	 */
	public class ExampleConfig 
	{

		public var main : InjectionExample;
		
		public function ExampleConfig(app:InjectionExample) 
		{
			this.main = app;
		}

		public var injectAfter:InjectAfter = new InjectAfter();
		
		public var injecteeClass:InjecteeClass;
		
		public var injectedClass:InjectedClass;
	}
}
