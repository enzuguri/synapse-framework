package com.enzuguri.synapse.builder.wire 
{
	import com.enzuguri.synapse.builder.asmetadata.ASMetaDataBuilder;
	import com.enzuguri.synapse.proxy.IInstanceProxy;
	import com.enzuguri.synapse.proxy.InstanceProxy;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.wire.EventCallback;
	import com.enzuguri.synapse.wire.IWiringController;
	import com.enzuguri.synapse.wire.WiredInstanceProxy;
	import com.enzuguri.synapse.wire.WiringController;

	/**
	 * @author alex
	 */
	public class ASWireBuilder 
		extends ASMetaDataBuilder 
	{
		protected var _controller : IWiringController;
		
		public function ASWireBuilder(autoAdd:Boolean = true)
		{
			_controller = new WiringController();
			super(autoAdd);
		}

		override protected function postProcess(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			return determineEvents(description, proxy);
		}
		
		private function determineEvents(description : XML, proxy : IInstanceProxy) : IInstanceProxy
		{
			var types:Array = [];
			
			var wireProxy:WiredInstanceProxy;
			
			var conNode:XML = description.factory.metadata[0];
			
			if(conNode && conNode.(@name == "Wire"))
			{
				var argNode:XML = conNode.arg[0];
				if(argNode)
					types = String(argNode.@value).split(",");
				
			}
			
			if (types.length > 0)
				wireProxy = new WiredInstanceProxy(proxy, _controller, types);
			
			
			for each (var node:XML in description.factory.method.metadata.(@name == "Wire"))
			{
				if(!wireProxy) wireProxy = new WiredInstanceProxy(proxy, _controller);
				wireProxy.addCallback(createEventCallback(node));
			}
				
			return wireProxy || proxy;
		}
		
		private function createEventCallback(node : XML) : EventCallback
		{
			
			var types:Array = String(node.arg.@value).split(",");
			var methodName:String = node.parent().@name;
			var translations:Array;
			trace(node);
			return new EventCallback(types, methodName, translations);
		}

		override public function addToRegistry(registry : IObjectRegistry) : void
		{
			super.addToRegistry(registry);
			
			if(!registry.hasTyped(IWiringController))
			{
				var name:String = getClassName(IWiringController);
				_controller.registry = registry;
				var p:IInstanceProxy = createInstanceProxy(name, IWiringController, InstanceProxy.SINGLETON, _controller);
				registry.registerProxy(p, name);
			}
		}
	}
}
