package com.enzuguri.synapse.registry 
{
	import com.enzuguri.synapse.proxy.IInstanceProxy;

	
	
	/**
	 * An IObjectRegistry manages a collection of <code>IInjectionProxy</code> instances. Instances of objects can be
	 * resolved ("created") by type or by name, an appropriate <code>IInjectionProxy</code> is found based on these 
	 * parameters and resolved using the <code>resolve()</code> method on that interface.
	 * 
	 * @author enzuguri contact: alex@alexfell.com
	 */
	public interface IObjectRegistry 
	{
		/**
		 * Determines wether this registry has an assocaited <code>IInstanceProxy</code> instance that would resolve
		 * to the given named string.
		 */
		function hasNamed(name : String) : Boolean;

		
		
		/**
		 * Determines wether this registry has an assocaited <code>IInstanceProxy</code> instance that would resolve
		 * to the given type.
		 */
		function hasTyped(type : Class) : Boolean;

		
		
		/**
		 * Given a named string the registry will attempt to find an assocaited <code>IInstanceProxy</code> instance
		 * and resolve the type. If the 'instance' parameter is given then it is passed to the found proxy for
		 * resolution.
		 * 
		 * @see IInstanceProxy#resolve()
		 */
		function resolveNamed(name : String, instance : Object = null) : *;

		
		
		/**
		 * Given a class type the registry will attempt to find an assocaited <code>IInstanceProxy</code> instance
		 * and resolve the type. If the 'instance' parameter is given then it is passed to the found proxy for
		 * resolution.
		 * 
		 * @see IInstanceProxy#resolve()
		 */
		function resolveTyped(type : Class, instance : Object = null) : *;

		
		
		/**
		 * Given a named string, the registry finds the corresponding <code>IInstanceProxy</code> and removes
		 * references to it. The 'dispose' parameter by default will also dispose of any objects being mananged
		 * by the proxy if found.
		 */
		function removeNamed(name : String, dispose : Boolean = true) : void;

		
		
		/**
		 * Given a target class type, the registry finds the corresponding <code>IInstanceProxy</code> and removes
		 * references to it. The 'dispose' parameter by default will also dispose of any objects being mananged
		 * by the proxy if found.
		 */
		function removeTyped(type : Class, dispose : Boolean = true) : void;

		
		
		/**
		 * Assocaites a <code>IInstanceProxy</code> instance with the given 'name' parameter so that it can be referenced
		 * by the <code>resolveNamed()</code> method.
		 * 
		 * @see #resolveNamed()
		 * @see #resolveTyped()
		 */
		function registerProxy(proxy : IInstanceProxy, name : String) : void;

		
		
		/**
		 * Attempts to dispose a given instance using <code>getProxyFromInstance()</code> to find the assocaited
		 * proxy. If the 'remove' parameter is given then the proxy is also disposed. Returns true if a proxy is found
		 * and false if one could not be found.
		 */
		function disposeInstance(instance : Object, remove : Boolean = false) : Boolean;

		
		
		/**
		 * Given an instance the registry performs a lookup to determine either which <code>IInstanceProxy</code>
		 * holds a reference to the given object, or which proxy can be used to create that object.
		 * 
		 * @see IInstanceProxy#matchesInstance()
		 */
		function getProxyFromInstance(instance : Object) : IInstanceProxy;
	}
}
