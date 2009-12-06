
package  
{
	import com.enzuguri.example.ExampleConfig;
	import com.enzuguri.example.InjectAfter;
	import com.enzuguri.example.WireReciever;
	import com.enzuguri.example.InjectedClass;
	import com.enzuguri.example.InjecteeClass;
	import com.enzuguri.example.WiredDispatcher;
	import com.enzuguri.synapse.builder.wire.ASWireBuilder;
	import com.enzuguri.synapse.registry.IObjectRegistry;
	import com.enzuguri.synapse.registry.ObjectRegistry;

	import flash.display.Sprite;

	/**
	 * @author Alex Fell
	 */
	public class InjectionExample 
		extends Sprite 
	{
		public function InjectionExample()
		{
			
			
			var config:ExampleConfig = new ExampleConfig(this);
			
			var registry:IObjectRegistry = new ObjectRegistry();
			var eventBuilder:ASWireBuilder = new ASWireBuilder();
			eventBuilder.buildIntoRegistry(registry, config);
			
			
			var bean:Object = registry.resolveTyped(InjecteeClass);
			
			var bean2:Object = registry.resolveTyped(InjecteeClass);
			trace("are these beans the same?", bean, bean2, bean === bean2);
			/*
			var injectedAfter:InjectAfter = new InjectAfter();
			
			eventBuilder.buildWithValue(registry, injectedAfter);
			*/
			
			var postIntance:InjectAfter = registry.resolveTyped(InjectAfter);
			
			trace("match these two", postIntance, config.injectAfter, postIntance == config.injectAfter);
			
			eventBuilder.buildWithClass(registry, WiredDispatcher);
			
			var instance:WiredDispatcher = registry.resolveTyped(WiredDispatcher);
			
			trace("did it work this time?", instance);

			eventBuilder.buildWithClass(registry, WireReciever);
			
			instance.raiseCompleteEvent();
		}
	}
}
