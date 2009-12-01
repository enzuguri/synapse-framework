
package com.enzuguri.synapse.support 
{

	/**
	 * @author Alex Fell
	 */
	public class NumberGeneratorClass 
	{
		private var _randomNumber:Number;
		
		public function NumberGeneratorClass() 
		{
			_randomNumber = Math.random();
		}
		
		
		public function toString() : String 
		{
			return "(StandaloneClass, randomNumber:" + _randomNumber + ")";
		}
	}
}
