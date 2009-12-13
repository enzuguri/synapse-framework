
package com.enzuguri.example 
{

	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	/**
	 * @author Alex Fell
	 */
	public class InjectionConfig 
	{
		
		[Inject]
		public var view1:Sprite;
		
		
		[Inject]
		public var model1:EventDispatcher;
		
		
		
	}
}
