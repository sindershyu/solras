package org.apache.solr.client.solras.request
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
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
		
		/** wait till the command has flushed */
		public static const WAIT_FLUSH:String 				= "waitFlush";
		  
		/** wait for the search to warm up */
		public static const WAIT_SEARCHER:String 			= "waitSearcher";
		  
		/** overwrite indexing fields */
		public static const OVERWRITE:String 				= "overwrite";
		  
		/** Commit everything after the command completes */
		public static const COMMIT:String 					= "commit";
		  
		/** Commit everything after the command completes */
		public static const OPTIMIZE:String 				= "optimize";
		
		/** Select the update processor to use.  A RequestHandler may or may not respect this parameter */
		public static const UPDATE_PROCESSOR:String 		= "update.processor";
		/**
		 * If optimizing, set the maximum number of segments left in the index after optimization.  1 is the default (and is equivalent to calling IndexWriter.optimize() in Lucene).
		 */
		public static const MAX_OPTIMIZE_SEGMENTS:String 	= "maxSegments";
   
		
		private var token:AsyncToken;
		
		private var solrParameters:SolrParams;
		
		public function UpdateRequest(solrClient:SolrClient)
		{
			super(solrClient, POST, "/update");
		}
		
		
		override public function getParams():Object
		{
			
			var add:XML = <add></add>;
			for each (var doc:SolrInputDocument in documentsToBeAdded)
			{
				add.appendChild(doc.getXML());	
			}
			return add;
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
			var response:UpdateResponse = new UpdateResponse();
			operation.addEventListener(ResultEvent.RESULT, response.resultHandler);
			operation.contentType = HTTPService.CONTENT_TYPE_XML;
			response.token = operation.send(getParams);		
			return response;
		}
	}
}