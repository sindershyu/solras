package org.apache.solr
{
	import flexunit.framework.TestCase;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.common.SolrInputDocument;
	
	public class SolrClientTest extends TestCase
	{

		private var client:SolrClient;
		
		public function SolrClientTest(methodName:String=null)
		{
			super(methodName);
		}
		
		//This method will be called before every test function
		override public function setUp():void
		{
			super.setUp();
			client = new SolrClient("http://83.80.18.122:8080/solr");
		}
		
		//This method will be called after every test function
		override public function tearDown():void
		{
			super.tearDown();
		}
		
		public function testAddDocument():void
		{
			var doc:SolrInputDocument = new SolrInputDocument();
			client.add(doc);
		}
		
	}
}