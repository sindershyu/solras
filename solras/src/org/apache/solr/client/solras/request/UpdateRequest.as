package org.apache.solr.client.solras.request
{
	import mx.rpc.AsyncToken;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.SolrRequest;
	import org.apache.solr.client.solras.SolrResponse;
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
		
		
		public function UpdateRequest(solrClient:SolrClient)
		{
			super(solrClient, POST, "/update");
		}
		
		
		public function setAction(action:String, waitFlush:Boolean=false, waitSearcher:Boolean=false, maxSegments:Number=1):UpdateRequest
		{
			if(solrParameters==null)
				solrParameters = new SolrParams();
			if(action == UpdateParams.OPTIMIZE)
			{
				solrParameters.setParamValue(UpdateParams.OPTIMIZE,"true");
				solrParameters.setParamValue(UpdateParams.MAX_OPTIMIZE_SEGMENTS,maxSegments.toString());
			}
			if(action == UpdateParams.COMMIT)
				solrParameters.setParamValue(UpdateParams.COMMIT, "true");
			
			solrParameters.setParamValue(UpdateParams.WAIT_FLUSH, waitFlush.toString());
			solrParameters.setParamValue(UpdateParams.WAIT_SEARCHER, waitSearcher.toString());
			
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
		
		override public function process(callback:Function=null):SolrResponse
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
			if(toBeDeletedById != null)
			{
				var deleteByID:XML = <delete></delete>;
				for each (var id:String in toBeDeletedById)
				{
					deleteByID.appendChild(<id>{id}</id>);
				}
				body = deleteByID;
			}
			if(toBeDeletedByQuery != null)
			{
				var deleteByQuery:XML = <delete></delete>;
				for each (var query:String in toBeDeletedByQuery)
				{
					deleteByQuery.appendChild(<query>{id}</query>);
				}
				body = deleteByQuery;
			}
			
			return super.send(new UpdateResponse(callback),body);
		}
	}
}