package com.enzuguri.synapse.proxy 
{
	import com.enzuguri.synapse.process.IInjectionProcess;
	import com.enzuguri.synapse.registry.IObjectRegistry;

	
	
	/**
	 * An IInstanceProxy contains all the information required to instantiate and inject an object. It manages
	 * a "processList" of <code>IInjectionProcess</code> instances, as well as holding a reference to the current
	 * object in its lifecycle.
	 * 
	 * @author enzuguri contact alex@alexfell.com
	 */
	public interface IInstanceProxy 
	{
		/**
		 * Returns a reference to the current instanciation of the target class.
		 */
		function get currentInstance() : Object;

		
		
		/**
		 * Returns an ordered list of type <code>IInjectionProcess</code> to be used in conjunction
		 * with this proxy instance.
		 */
		function get processList() : Array;

		
		
		/**
		 * Disposes of this proxy by removing all references any instances created and removing and processes
		 * associated.
		 */
		function dispose(registry : IObjectRegistry) : void;

		
		
		/**
		 * Given an instance, this 'uninjects' all the processes on the instance. This does not dispose of the proxy
		 * itself see <code>dispose()</code>.
		 * @see #dispose()
		 */
		function disposeInstance(registry : IObjectRegistry, instance : Object = null) : void;

		
		
		/**
		 * Adds a process to the injection queue.
		 */
		function addProcess(process : IInjectionProcess) : void;

		
		
		/**
		 * Returns the lifecycle type of this proxy for use when implementing differing lifecycle management types
		 * e.g. singletons.
		 */
		function get type() : String;

		
		
		/**
		 * Returns the class type that this proxy creates, this is the actual implementation of the class.
		 */
		function get clazz() : Class;

		
		
		/**
		 * Returns the string identifier for this proxy, this is used match against named injections. 
		 */
		function get name() : String;

		
		
		/**
		 * Determines whether the object was, or could be, constructed using this proxy.
		 */
		function matchesInstance(instance : Object) : Boolean;

		
		
		/**
		 * Resolves this proxy, this either creates a new instance of the intended class, or retrieves a pooled
		 * one depending on the implementation.
		 */
		function resolve(registry : IObjectRegistry) : *;

		
		
		/**
		 * Determines wether this proxy has already resolved its target, used when resolving looped references
		 * and lifecycle management.
		 */
		function get processed() : Boolean;
	}
}
