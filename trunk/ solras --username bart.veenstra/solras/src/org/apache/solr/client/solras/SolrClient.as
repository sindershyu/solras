package org.apache.solr.client.solras
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.apache.solr.client.solras.request.UpdateRequest;
	import org.apache.solr.client.solras.response.QueryResponse;
	import org.apache.solr.client.solras.response.UpdateResponse;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.params.SolrParams;

	public class SolrClient
	{
		public static var DATE_FORMAT_UTC:String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
		
		public var solrService:HTTPService;
		private var rootUrl:String;
		
		public function SolrClient(rootUrl:String=null,destination:String=null)
		{
			this.rootUrl = rootUrl;
			solrService = new HTTPService();
			solrService.url = rootUrl;
			solrService.addEventListener(FaultEvent.FAULT,traceFaultHandler);
		}
		
		private function traceFaultHandler(e:FaultEvent):void 
		{
			trace(e);
		}
		
		public function setPath(path:String):void
		{
			solrService.url = rootUrl + path;
		}
		
		public function add(doc:SolrInputDocument):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest();
			request.add(doc);
			return request.process(this) as UpdateResponse;
		}
		
		public function addCollection(docs:Array):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest();
			request.addCollection(docs);
			return request.process(this) as UpdateResponse;
		}
		
		public function commit():UpdateResponse {
			return null;
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