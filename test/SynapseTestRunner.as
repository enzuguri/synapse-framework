package
{
	import com.enzuguri.synapse.suites.SynapseTestSuite;

	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;

	import flash.display.Sprite;

	public class SynapseTestRunner extends Sprite
	{
		public function SynapseTestRunner()
		{
			var core:FlexUnitCore = new FlexUnitCore();
			core.addListener(new CIListener());
			core.addListener(new TraceListener());
			core.run(SynapseTestSuite);
		}
	}
}