package org.apache.solr.client.solras
{
	import mx.rpc.http.HTTPMultiService;
	
	import org.apache.solr.client.solras.request.QueryRequest;
	import org.apache.solr.client.solras.request.UpdateRequest;
	import org.apache.solr.client.solras.response.QueryResponse;
	import org.apache.solr.client.solras.response.UpdateResponse;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.params.SolrParams;
	import org.apache.solr.common.params.UpdateParams;

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
		}
		
		public function add(doc:SolrInputDocument,callback:Function=null):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.add(doc);
			return request.process(callback) as UpdateResponse;
		}
		
		public function addCollection(docs:Array,callback:Function=null):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.addCollection(docs);
			return request.process(callback) as UpdateResponse;
		}
		
		public function commit(callback:Function=null,waitFlush:Boolean=false, waitSearcher:Boolean=false):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.setAction(UpdateParams.COMMIT,waitFlush,waitSearcher);
			return request.process(callback) as UpdateResponse;
		}
		
		public function optimize(callback:Function=null,waitFlush:Boolean=false, waitOptimize:Boolean=false):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.setAction(UpdateParams.OPTIMIZE, waitFlush, waitOptimize);
			return request.process(callback) as UpdateResponse;
		}
		
		public function deleteById(id:String,callback:Function=null):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.deleteByID(id);
			return request.process(callback) as UpdateResponse;
		}
		
		public function deleteByQuery(query:String,callback:Function=null):UpdateResponse {
			var request:UpdateRequest = new UpdateRequest(this);
			request.deleteByQuery(query);
			return request.process(callback) as UpdateResponse;
		}
		
		public function query(params:SolrParams,callback:Function=null):QueryResponse {
			var request:QueryRequest = new QueryRequest(this,params);
			return request.process(callback) as QueryResponse;
		}
		
	}
}