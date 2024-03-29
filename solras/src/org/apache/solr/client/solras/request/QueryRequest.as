package org.apache.solr.client.solras.request
{
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.SolrRequest;
	import org.apache.solr.client.solras.SolrResponse;
	import org.apache.solr.client.solras.response.QueryResponse;
	import org.apache.solr.common.params.CommonParams;
	import org.apache.solr.common.params.SolrParams;

	public class QueryRequest extends SolrRequest
	{
		
		
		public function QueryRequest(client:SolrClient,params:SolrParams)
		{
			super(client,SolrRequest.GET);
			this.solrParameters = params; 
		}
		
		override public function getPath():String
		{
			var qt:String = getParams().getParam(CommonParams.QT);
			if(qt == null)
				qt = super.getPath();
			if(qt!=null && qt.charAt(0) == "/")
				return qt;
			return "/select";
		}
		
		override public function process(callback:Function=null):SolrResponse
		{
			var qr:QueryResponse = new QueryResponse(null,super.solrClient,callback);
			return super.send(qr);
		}
		
	}
}