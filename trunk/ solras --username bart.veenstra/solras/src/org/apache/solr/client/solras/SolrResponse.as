package org.apache.solr.client.solras
{
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.apache.solr.client.solras.response.ResponseProcessor;
	import org.apache.solr.common.utils.NamedList;

	public class SolrResponse
	{
		public var elapsedTime:Number;
		private var _response:NamedList;
		
		public var requestUrl:String;
  		
		public function resultHandler(resultEvent:ResultEvent):void
		{
			var diff:int = getTimer() - elapsedTime;
			elapsedTime = diff;
			var xml:XML = new XML(resultEvent.result as XMLNode);
			response = new NamedList();
			ResponseProcessor.process(new XML(resultEvent.result as XMLNode),response);
//			trace("Request " + requestUrl + " executed in " + diff);
//			trace("Request Result: " +  new XML(resultEvent.result as XMLNode).toXMLString());
		}
		
		public function faultHandler(fault:FaultEvent):void 
		{
			trace("Error executing Solr Request: [" + fault.fault.faultCode + "]" + fault.fault.faultString);
			trace("Detail: " + fault.fault.faultDetail);
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