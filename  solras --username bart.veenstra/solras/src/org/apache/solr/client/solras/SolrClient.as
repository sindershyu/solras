package org.apache.solr.client.solras
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPMultiService;
	
	import org.apache.solr.client.solras.request.UpdateRequest;
	import org.apache.solr.client.solras.response.QueryResponse;
	import org.apache.solr.client.solras.response.UpdateResponse;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.params.SolrParams;

	public class SolrClient
	{
		public static var DATE_FORMAT_UTC:String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
		
		public var solrService:HTTPMultiService;
		private var rootUrl:String;
		
		public function SolrClient(rootUrl:String=null,destination:String=null, useProxy:Boolean=false)
		{
			this.rootUrl = rootUrl;
			solrService = new HTTPMultiService();
			solrService.baseURL = rootUrl;
						
			solrService.useProxy = useProxy	;
			solrService.addEventListener(FaultEvent.FAULT,traceFaultHandler);
		}
		
		private function traceFaultHandler(e:FaultEvent):void 
		{
			trace(e);
		}
		
		public function add(doc:SolrInputDocument):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.add(doc);
			return request.process() as UpdateResponse;
		}
		
		public function addCollection(docs:Array):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.addCollection(docs);
			return request.process() as UpdateResponse;
		}
		
		public function commit(waitFlush:Boolean=false, waitOptimize:Boolean=false):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			return request.process() as UpdateResponse;
		}
		
		public function optimize():UpdateResponse {
			return null;
		}
		
		public function updateById(id:String):UpdateResponse {
			return null;
		}
		
		public function updateByQuery(query:String):UpdateResponse {
			return null;
		}
		
		public function query(params:SolrParams):QueryResponse {
			return null;	
		}
		
		
	}
}