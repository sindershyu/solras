package org.apache.solr.client.solras.request
{
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.response.SolrResponse;
	import org.apache.solr.common.params.SolrParams;

	public interface ISolrRequest
	{
		function getParams():Object;
		function process(solrServer:SolrClient):SolrResponse
		
	}
}