package org.apache.solr.client.solras.response
{
	import mx.rpc.events.ResultEvent;

	public class UpdateResponse extends SolrResponseBase
	{
		
		public function UpdateResponse()
		{
		}
		
		public function resultHandler(result:ResultEvent):void
		{
			trace(result);
		}
	}
}