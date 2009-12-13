
package com.enzuguri.synapse.wire.process 
{
	import flash.events.IEventDispatcher;
	import com.enzuguri.synapse.wire.IWiringController;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class WatchWireProcess 
		implements IInjectionProcess 
	{

		private var _controllerName:String;
		
		private var _eventTypes:Array;

		
		
		public function WatchWireProcess(eventTypes:Array, controllerName:String) 
		{
			_eventTypes = eventTypes;
			_controllerName = controllerName;
		}

		
		
		public function dispose():void
		{
			_eventTypes.length = 0;
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			var controller:IWiringController = registry.resolveNamed(_controllerName);
			var dispatcher:IEventDispatcher = target as IEventDispatcher;
			
			if(controller && dispatcher)
				controller.watchDispatcher(dispatcher, _eventTypes);
			
			return target;
		}

		
		
		public function removeInjection(registry:IObjectRegistry, target:Object):Object
		{
			var controller:IWiringController = registry.resolveNamed(_controllerName);
			var dispatcher:IEventDispatcher = target as IEventDispatcher;
			
			if(controller && dispatcher)
				controller.ignoreDispatcher(dispatcher, _eventTypes);
				
			return target;
		}
	}
}
