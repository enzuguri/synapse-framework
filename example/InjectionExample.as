
package  
{
	import com.enzuguri.example.InjectedClass;
	import com.enzuguri.example.InjecteeClass;
	import com.enzuguri.synapse.builder.asmetadata.ASMetaDataBuilder;
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
			
			var builder:ASMetaDataBuilder = new ASMetaDataBuilder();
			
			
			builder.buildWithClass(registry, InjectedClass);
			builder.buildWithClass(registry, InjecteeClass);
			
			
			var bean:Object = registry.retrieveTyped(InjecteeClass);
			
			trace("created and object", bean);
			
			var bean2:Object = registry.retrieveTyped(InjecteeClass);
			
			
			trace(bean, bean2);
		}
	}
}
