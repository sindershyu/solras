package org.apache.solr.client.solras.request
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.response.SolrResponse;
	import org.apache.solr.client.solras.response.UpdateResponse;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.params.SolrParams;

	public class UpdateRequest extends SolrRequest  
	{
		
		private var documentsToBeAdded:Array; //SolrInputDocument
		private var toBeDeletedById:Array; //of String;
		private var toBeDeletedByQuery:Array; // of String
		
		private var token:AsyncToken;
		
		private var solrParameters:SolrParams;
		
		public function UpdateRequest()
		{
			super(POST, "/update");
		}
		
		
		override public function getParams():Object
		{
			var p:Object = new Object();
			p.add = new Object();
			p.add.doc = new Array();
			
			 
			return p;
		}
		 
		public function clear():void
		{
			documentsToBeAdded = null;
			toBeDeletedById = null;
			toBeDeletedByQuery = null;
		}
		
		public function add(documentToBeAdded:SolrInputDocument):UpdateRequest
		{ 
			if(documentsToBeAdded == null)
				documentsToBeAdded = new Array();
			documentsToBeAdded.push(documentsToBeAdded);
			return this;	
		}
		
		public function addCollection(docs:Array):UpdateRequest
		{ 
			docs.forEach(function(item:*, index:int, arr:Array):void{add(item as SolrInputDocument)});
			return this;	
		}
		
		public function deleteByID(id:String):UpdateRequest
		{
			if(toBeDeletedById==null)
				toBeDeletedById = new Array();
			toBeDeletedById.push(id);
			return this;	
		}
		
		public function deleteByQuery(query:String):UpdateRequest
		{
			if(toBeDeletedByQuery==null)
				toBeDeletedByQuery = new Array();
			toBeDeletedByQuery.push(query);
			return this;	
		}
		
		override public function process(solrClient:SolrClient):SolrResponse
		{
			var response:UpdateResponse = new UpdateResponse();			
			solrClient.solrService.method = super.method;
			solrClient.setPath(super.path);
			response.token = solrClient.solrService.send(getParams());
			return response;
		}
	}
}