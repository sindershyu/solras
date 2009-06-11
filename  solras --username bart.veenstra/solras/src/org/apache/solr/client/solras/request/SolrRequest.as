package org.apache.solr.client.solras.request
{
	import mx.rpc.http.HTTPService;
	import mx.rpc.http.Operation;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.response.SolrResponse;
	
	

	public class SolrRequest implements ISolrRequest
	{
		public static const POST:String = "POST";
		public static const GET:String = "GET";
		
		protected var method:String;
		protected var path: String;
		protected var operation:Operation;
		
		public function SolrRequest(client:SolrClient, httpMethod:String, path:String)
		{
			operation = new Operation(client.solrService,"update");
			operation.method = httpMethod;
			operation.url = client.solrService.baseURL + path;
//			operation.resultFormat = HTTPService.RESULT_FORMAT_XML;
		}
		
		public function getParams():Object {
			throw new Error("Not implemented");
		}
		public function process():SolrResponse {
			throw new Error("Not implemented");
		}
	}
}