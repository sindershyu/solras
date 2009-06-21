package org.apache.solr.client.solras
{
	import flash.utils.getTimer;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.http.Operation;
	
	import org.apache.solr.common.params.SolrParams;
	
	

	public class SolrRequest
	{
		public static const POST:String = "POST";
		public static const GET:String = "GET";
		
		protected var method:String;
		protected var path: String;
		protected var baseUrl:String;
		protected var operation:Operation;
		public var solrParameters:SolrParams;
		protected var solrClient:SolrClient;
		
		
		public function getParams():SolrParams
		{
			return solrParameters;
		}
		
		public function SolrRequest(client:SolrClient, httpMethod:String, path:String=null)
		{
			this.solrClient = client;
			this.path = path;
			this.baseUrl = client.solrService.baseURL;
			operation = new Operation(client.solrService,"update");
			operation.method = httpMethod;
		}
		
		public function process(callback:Function=null):SolrResponse 
		{
			throw new Error("Not implemented");
		}
		
		public function getPath():String 
		{
			return path;
		}
		
		
		protected function send(response:SolrResponse, body:Object=""):SolrResponse 
		{
			response.elapsedTime = getTimer();
			operation.resultFormat = HTTPService.RESULT_FORMAT_XML;
			operation.addEventListener(ResultEvent.RESULT, response.resultHandler);
			operation.addEventListener(FaultEvent.FAULT, response.faultHandler);
			operation.contentType = HTTPService.CONTENT_TYPE_XML;
			operation.url = baseUrl + getPath() + assembleParameters();
			operation.send(body);
			response.requestUrl = operation.url;
			return response;	
		}
		
		
		private function assembleParameters():String
		{
			var p:SolrParams = getParams();
			var s:String = "";
			if(p==null)
				return s;
			var names:Array = p.getParameterNames();
			for (var i:Number = 0; i < names.length; i++)
			{
				if(i == 0)
					s+= "?";
				var value:Object = p.getParam(names[i]);
				s += names[i] + "=" + escape(value.toString());
				
				if(i < names.length-1)
				 	s+= "&";
				
			} 
			return s;
		}
		
	}
}