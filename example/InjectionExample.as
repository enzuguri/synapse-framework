
package  
{
	import com.enzuguri.example.InjectionConfig;
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
			
			var registry:IObjectRegistry = new ObjectRegistry();
			
			var eventBuilder:ASWireBuilder = new ASWireBuilder();
			eventBuilder.addToRegistry(registry);
			
			
			eventBuilder.buildIntoRegistry(registry, InjectionConfig);
			
//			registry.resolveTyped("iidhgksdh")
			
			
			
			
			
			
			
			
			eventBuilder.buildWithClass(registry, InjectedClass);
			eventBuilder.buildWithClass(registry, InjecteeClass);
			
			
			var bean:Object = registry.resolveTyped(InjecteeClass);
			
			trace("created and object", bean);
			
			var bean2:Object = registry.resolveTyped(InjecteeClass);
			
			
			trace(bean, bean2);
			
			
			
			eventBuilder.buildWithClass(registry, WiredDispatcher);
			
			var instance:WiredDispatcher = registry.resolveTyped(WiredDispatcher);
			
			trace("did it work this time?", instance);

			eventBuilder.buildWithClass(registry, WireReciever);
			
			instance.raiseCompleteEvent();
		}
	}
}
