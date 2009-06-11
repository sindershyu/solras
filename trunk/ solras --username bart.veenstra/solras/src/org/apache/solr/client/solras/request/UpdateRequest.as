package org.apache.solr.client.solras.request
{
	import mx.rpc.AsyncToken;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.response.SolrResponse;
	import org.apache.solr.client.solras.response.UpdateResponse;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.params.SolrParams;
	import org.apache.solr.common.params.UpdateParams;

	public class UpdateRequest extends SolrRequest  
	{
		
		private var documentsToBeAdded:Array; //SolrInputDocument
		private var toBeDeletedById:Array; //of String;
		private var toBeDeletedByQuery:Array; // of String
		private var token:AsyncToken;
		
		public var solrParameters:SolrParams;
		
		public function UpdateRequest(solrClient:SolrClient)
		{
			super(solrClient, POST, "/update");
		}
		
		
		override public function getParams():SolrParams
		{
			return solrParameters;
		}
		
		public function setAction(action:String, waitFlush:Boolean=false, waitSearcher:Boolean=false, maxSegments:Number=1):UpdateRequest
		{
			if(solrParameters==null)
				solrParameters = new SolrParams();
			if(action == UpdateParams.OPTIMIZE)
			{
				solrParameters.setParam(UpdateParams.OPTIMIZE,true);
				solrParameters.setParam(UpdateParams.MAX_OPTIMIZE_SEGMENTS,maxSegments);
			}
			if(action == UpdateParams.COMMIT)
				solrParameters.setParam(UpdateParams.COMMIT, true);
			
			solrParameters.setParam(UpdateParams.WAIT_FLUSH, waitFlush);
			solrParameters.setParam(UpdateParams.WAIT_SEARCHER, waitSearcher);
			
			return this;
		}
		
		
		public function clear():void
		{
			documentsToBeAdded = null;
			toBeDeletedById = null;
			toBeDeletedByQuery = null;
			solrParameters = new  SolrParams();
		}
		
		public function add(documentToBeAdded:SolrInputDocument):UpdateRequest
		{ 
			if(documentsToBeAdded == null)
				documentsToBeAdded = new Array();
			documentsToBeAdded.push(documentToBeAdded);
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
		
		override public function process():SolrResponse
		{
			var body:Object = "";
			if(documentsToBeAdded!=null && documentsToBeAdded.length > 0)
			{
				var add:XML = <add></add>;
				for each (var doc:SolrInputDocument in documentsToBeAdded)
				{
					add.appendChild(doc.getXML());	
				}
				body = add;
			}
			return super.send(new UpdateResponse(),body);
		}
	}
}