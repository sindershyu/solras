package org.apache.solr.client.solras.response
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import org.apache.solr.client.solras.SolrResponse;

	public class UpdateResponse extends SolrResponse
	{
		
		public function UpdateResponse()
		{
		}
		
		override public function resultHandler(result:ResultEvent):void
		{
			super.resultHandler(result);
		}
		
		override public function faultHandler(fault:FaultEvent):void 
		{
			super.faultHandler(fault);
		}
	}
}