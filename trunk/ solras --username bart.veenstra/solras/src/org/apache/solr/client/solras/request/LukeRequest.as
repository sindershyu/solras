package org.apache.solr.client.solras.request
{
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.SolrRequest;
	import org.apache.solr.client.solras.SolrResponse;
	import org.apache.solr.client.solras.response.LukeResponse;
	import org.apache.solr.common.params.CommonParams;
	import org.apache.solr.common.params.SolrParams;

	public class LukeRequest extends SolrRequest
	{
		public var fields:Array;
		public var numTerms:int = -1;
		public var showSchema:Boolean = false;
		
		public function LukeRequest(client:SolrClient)
		{
			super(client,GET,"/admin/luke");
		}
		
		public function addField(field:String):void 
		{
			if(fields == null)
				fields = new Array();
			fields.push(field);
		}
		
		public function setFields(fields:Array):void 
		{
			this.fields = fields;
		}
		
		override public function getParams() : SolrParams 
		{
			var params:SolrParams = new SolrParams();
			if(fields != null && fields.length > 0)
				params.addParam(CommonParams.FL, fields.toString());
			if(numTerms >= 0)
				params.addParam("numTerms", "numTerms+");
			if(showSchema)
				params.addParam("show", "schema");
			return params;
		}
		
		override public function process():SolrResponse
		{
			return super.send(new LukeResponse());
		}
	}
}