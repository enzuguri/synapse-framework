package com.enzuguri.synapse.parser.metadata 
{
	import com.enzuguri.synapse.parser.ProcessParserBase;
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.wire.EventCallback;

	import flash.utils.describeType;

	/**
	 * @author alex
	 */
	public class MetaDataParser 
		extends ProcessParserBase 
	{
		override public function determineInjectionProcesses(target : Object, controllerName:String) : Array
		{
			var processes : Array = [];
			var description : XML;
			
			if(target is Class)
			{
				description = describeType(target);
				processes[0] = determineConstructor(description, target as Class);
			}
			else
				description = describeType(target.constructor);
			
			//first vars
			processes = processes.concat(determineVariables(description).sortOn("order"));
			
			//then watchers
			processes = processes.concat(determineWatchProcesses(description, controllerName).sortOn("order"));
			
			//then callbacks
			processes = processes.concat(determineCallbacks(description, controllerName).sortOn("order"));

			//then methods
			processes = processes.concat(determineMethods(description).sortOn("order"));
			
			
			return processes;
		}
		
		
		protected function determineConstructor(description : XML, clazz : Class) : IInjectionProcess
		{
			var process : IInjectionProcess;
			var node : XML = description.factory.constructor[0];
			if (node)
			{
				var xmk : XML = getRealConstrcutorXML(clazz, node.children().length());
			}
			else
				process = super.createNullConstructor(clazz);
				
			return process;	
		}
		
		
		protected function determineVariables(description : XML) : Array
		{
			var properties : Array = [];
			for each (var node:XML in description.factory.*.(name() == "variable" || name() == "accessor").metadata.(@name == "Inject"))
			{
				var propertyName : String = node.parent().@name.toString();
				var registryName : String = node.parent().@type.toString();
			
				if (node.hasOwnProperty('arg') && node.arg.(@key == 'name').length)
					registryName = node.arg.@value.toString();
				
				properties[properties.length] = createPropertyProcess(propertyName, registryName);
			}
			return properties;
		}

		
		
		
		
		protected function determineWatchProcesses(description : XML, controlName:String) : Array
		{
			var watchers:Array = [];
			for each (var watchNode:XML in description.factory.metadata.(@name == "Wire"))
			{
				var types : Array = [];
				var controllerName : String = controlName;
			
				for each (var argument : XML in watchNode.elements("arg")) 
				{
					if(argument.@key == "controller")
					controllerName = String(argument.@value);
				else if(argument.@key == "dispatch")
					types = String(argument.@value).split(",");
				}
			
				if(types.length > 0)
					watchers[watchers.length] = createWatchProcess(types, controllerName);
			}
			
			return watchers;
		}

		
		protected function determineCallbacks(description : XML, controlName:String) : Array
		{
			var callbacks:Array = [];
			for each (var method:XML in description.factory.method.metadata.(@name == "Wire"))
				pushEventCallbacks(method, callbacks, controlName);
				
			for each (var accessor:XML in description.factory.*.(name() == "accessor").metadata.(@name == "Wire"))
			{
				pushEventCallbacks(accessor, callbacks, controlName, true);	
			}
				
			return callbacks;
		}
		
		protected function pushEventCallbacks(node : XML, callbacks : Array, controlName : String, 
			forceAccessor:Boolean = false) : void
		{
			
			var types : Array = [];
			var controllerName : String = controlName;
			var translations : Array;
			var priority : int = 0;
			var methodName : String = node.parent().@name;
			var autoWake : Boolean = true;
			
			for each(var arg:XML in node.arg)
			{
				switch(String(arg.@key))
				{
					case "handle":
						types = String(arg.@value).split(",");
						break;
					case "translations":
						translations = String(arg.@value).split(",");
						break;
					case "order":
						priority = parseInt(arg.@value);
						break;
					case "controller":
						controllerName = String(arg.@value);
						break;
					case "wake":
						autoWake = String(arg.@value) != "false";
						break;		
				}
			}
			
			var len : int = types.length;
			for (var i : int = 0;i < len;i++) 
			{
				var callback : EventCallback = new EventCallback(types[i], methodName, priority, translations, forceAccessor);
				// Pass the 'master' controller name to the process, but the custom name to the callback
				callbacks[callbacks.length] = createEventCallbackProcess(callback, autoWake, controlName);	
			}
		}
		
		
		protected function determineMethods(description : XML) : Array
		{
			var methods : Array = [];
			for each (var node:XML in description.factory.method.metadata.(@name == "Inject"))
			{
				var methodName : String = node.parent().@name.toString();
				var registryNames : Array = [];
				var order:int = 0;
				
				for each (var arg : XML in node.arg) 
				{
					if(arg.@key == "order")
						order = parseInt(String(arg.@value));
					else if(arg.@key == "name")
						registryNames = String(arg.@value).split(",");	
				}
				
				if(registryNames.length == 0)
				{
					var index : int = 0; 
					for each (var parameter : XML in node.parent().parameter)
					{
						registryNames[index] = parameter.@type.toString();
						index++;
					}
				}
				
				methods[methods.length] = createMethodProcess(methodName, registryNames, order);
			}
			return methods;
		}
		
		
		
		protected function getRealConstrcutorXML(clazz : Class, length : int) : XML
		{
			trace("contructor length", length);
			var object : Object;
			try
			{
				switch (length)
				{
					case 0 : 
						(object = new clazz());
						break;
					case 1 : 
						(object = new clazz(null)); 
						break;
					case 2 : 
						(object = new clazz(null, null)); 
						break;
					case 3 : 
						(object = new clazz(null, null, null)); 
						break;
					case 4 : 
						(object = new clazz(null, null, null, null)); 
						break;
					case 5 : 
						(object = new clazz(null, null, null, null, null)); 
						break;
					case 6 : 
						(object = new clazz(null, null, null, null, null, null)); 
						break;
					case 7 : 
						(object = new clazz(null, null, null, null, null, null, null)); 
						break;
					case 8 : 
						(object = new clazz(null, null, null, null, null, null, null, null)); 
						break;
					case 9 : 
						(object = new clazz(null, null, null, null, null, null, null, null, null)); 
						break;
					case 10 : 
						(object = new clazz(null, null, null, null, null, null, null, null, null, null)); 
						break;
				}
			}
			catch (error : Error)
			{
				trace(error);
			}
			
			return describeType(clazz);
		}
	}
}
