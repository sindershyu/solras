package org.apache.solr.client.solras
{
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.apache.solr.client.solras.response.ResponseProcessor;
	import org.apache.solr.common.utils.NamedList;

	public class SolrResponse
	{
		public var elapsedTime:Number;
		private var _response:NamedList;
		private var logger:ILogger = Log.getLogger("org.apache.solr.client.solras.SolrResponse");
		public var requestUrl:String;
		private var callback:Function;
		public var xml:XML;
		
		public function SolrResponse(callback:Function=null)
		{
			this.callback = callback;
		}
  		
		public function resultHandler(resultEvent:ResultEvent):void
		{
			 
			var diff:int = getTimer() - elapsedTime;
			elapsedTime = diff;
			var xml:XML = new XML(resultEvent.result as XMLNode);
			this.xml = xml;
			var result:NamedList = new NamedList();
			result.name = "Solr Server Response";
			ResponseProcessor.process(new XML(resultEvent.result as XMLNode),result);
			response = result;
			if(callback!=null);
				callback.call(null,this);
			logger.info("Request " + requestUrl + " executed in " + diff);
			logger.info("Request Result: " +  new XML(resultEvent.result as XMLNode).toXMLString());
		}
		
		public function faultHandler(fault:FaultEvent):void 
		{
			logger.info("Error executing Solr Request: [" + fault.fault.faultCode + "]" + fault.fault.faultString);
			logger.info("Detail: " + fault.fault.faultDetail);
		}
		
		public function set response(result:NamedList):void{
			_response = result;
		}
		
		public function get response():NamedList
		{
			return _response;
		}
	}
}