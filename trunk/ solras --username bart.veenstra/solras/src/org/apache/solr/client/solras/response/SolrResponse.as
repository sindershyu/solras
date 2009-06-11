package org.apache.solr.client.solras.response
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	public class SolrResponse
	{
		public var elapsedTime:Number;
  		
		public var token:AsyncToken;
		
		[Bindable]public var response:Object;
		
		public function SolrResponse()
		{
		}
		
		public function resultHandler(result:ResultEvent):void
		{
			response = result.result;
			trace(result);
			throw new Error("Not implemnted. Abstract base class");
		}
		
	}
}