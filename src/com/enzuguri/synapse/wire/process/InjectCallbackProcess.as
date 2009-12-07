
package com.enzuguri.synapse.wire.process 
{
	import com.enzuguri.synapse.wire.IWiringController;
	import com.enzuguri.synapse.wire.EventCallback;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	/**
	 * @author Alex Fell
	 */
	public class InjectCallbackProcess implements IInjectionProcess 
	{

		private var _wired:Boolean;
		private var _controllerName:String;
		private var _callback:EventCallback;

		
		
		public function InjectCallbackProcess(callback:EventCallback, controllerName:String) 
		{
			_callback = callback;
			_controllerName = controllerName;
			_wired = false;
		}
		
		public function dispose():void
		{
			_callback.dispose();
			_callback = null;
		}

		
		
		public function applyInjection(registry:IObjectRegistry, target:Object):Object
		{
			if(!_wired)
			{
				var controller:IWiringController = registry.resolveNamed(_controllerName);
				if(controller)
				{
					_wired = true;
					controller.registerCallback(_callback);
				}
			}
			
			return target;
		}
		
		
		
		public function removeInjection(registry:IObjectRegistry, target:Object):Object
		{
			var controller:IWiringController = registry.resolveNamed(_controllerName);
			
			if(controller)
				controller.removeCallback(_callback);
			
			return target;
		}
		
		
		
		public function get wired():Boolean
		{
			return _wired;
		}
		
		
		
		public function set wired(value:Boolean):void
		{
			_wired = value;
		}
	}
}
