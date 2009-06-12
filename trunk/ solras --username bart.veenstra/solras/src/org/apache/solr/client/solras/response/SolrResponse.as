package org.apache.solr.client.solras.response
{
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class SolrResponse
	{
		public var elapsedTime:Number;
  		
		[Bindable]public var result:XMLNode;
		
		public function SolrResponse()
		{
		}
		
		public function resultHandler(resultEvent:ResultEvent):void
		{
			result = resultEvent.result as XMLNode;
			var diff:int = getTimer() - elapsedTime;
			elapsedTime = diff;
			trace(result + diff);
		}
		
		public function faultHandler(fault:FaultEvent):void 
		{
			trace("Error executing Solr Request: [" + fault.fault.faultCode + "]" + fault.fault.faultString);
			trace("Detail: " + fault.fault.faultDetail);
		}
	}
}