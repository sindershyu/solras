package org.apache.solr.client.solras.response
{
	import flash.utils.getTimer;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
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
			trace("Request " + requestUrl + " executed in " + diff);
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