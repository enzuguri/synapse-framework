
package com.enzuguri.example
{

	/**
	 * @author Alex Fell
	 */
	public class InjecteeClass 
	{
		[Inject]
		public var someProperty:InjectedClass;
		
		private var _rand:Number;
		
		public function InjecteeClass() 
		{
			_rand = Math.random();
		}
		
		
		
		public function toString() : String 
		{
			return "InjecteeClass random number:" + _rand;
		}
	}
}
