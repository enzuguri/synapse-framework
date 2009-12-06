package com.enzuguri.example 
{

	/**
	 * @author alex
	 */
	public class InjectAfter 
	{
		[Inject]
		public var myinjection:InjectedClass;

		
		public function toString() : String
		{
			return "post inject::" + myinjection;
		}
	}
}
