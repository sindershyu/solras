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
		private var logger:ILogger = Log.getLogger("org.apache.solr.client.solras.SolrResponse");
		private var callback:Function;

		public 	var elapsedTime:Number;
		public 	var response:NamedList;
		public 	var requestUrl:String;
		
		
		[Bindable] 
		public var requestPending:Boolean = true;
		
		public function SolrResponse(callback:Function=null)
		{
			this.callback = callback;
		}
  		
		public function resultHandler(resultEvent:ResultEvent):void
		{
			var diff:int = getTimer() - elapsedTime;
			elapsedTime = diff;
			response = new NamedList();
			response.name = "Solr Server Response";
			ResponseProcessor.process(new XML(resultEvent.result as XMLNode),response);
			process(response);
			logger.info("Request " + requestUrl + " executed in " + diff);
			logger.info("Request Result: " +  new XML(resultEvent.result as XMLNode).toXMLString());
			if(callback!=null);
				callback.call(null,this);
			
			requestPending = false;	
		}
		
		public function process(response:NamedList):void 
		{
			
		}
		
		public function faultHandler(fault:FaultEvent):void 
		{
			logger.info("Error executing Solr Request: [" + fault.fault.faultCode + "]" + fault.fault.faultString);
			logger.info("Detail: " + fault.fault.faultDetail);
		}
	}
}