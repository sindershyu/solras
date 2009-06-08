package org.apache.solr.client.solras.request
{
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.response.SolrResponse;
	import org.apache.solr.common.params.SolrParams;
	
	

	public class SolrRequest implements ISolrRequest
	{
		public static const POST:String = "POST";
		public static const GET:String = "GET";
		
		protected var method:String;
		protected var path: String;
		
		public function SolrRequest(httpMethod:String, path:String)
		{
			this.method = httpMethod;
			this.path = path;
		}
		
		public function getParams():Object {
			throw new Error("Not implemented");
		}
		public function process(solrClient:SolrClient):SolrResponse {
			throw new Error("Not implemented");
		}
		
		
		
	}
}