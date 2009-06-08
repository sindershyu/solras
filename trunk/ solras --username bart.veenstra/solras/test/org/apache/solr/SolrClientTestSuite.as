package org.apache.solr
{
	import flexunit.framework.TestSuite;
	
	public class SolrClientTestSuite extends TestSuite
	{
		public function SolrClientTestSuite(param:Object=null)
		{
			super(param);
		}
		
		// this method shall be called when this suite is selected for running.
		public static function suite():TestSuite
		{
			var newTestSuite:TestSuite = new TestSuite();
			newTestSuite.addTest(new SolrClientTest());
			return newTestSuite;
		}
	}
}