package org.apache.solr.common.params
{
	public interface ISolrParams
	{
		function getParam(param:String):String;
		
		function getBool(param:String):Boolean;
		
		function getNumber(param:String):Number;
		
		function getParams(param:String):Array;
		
		function getParameterNames():Array; 
		
		function getFieldBool(field:String, param:String):Boolean;
		
		function getFieldNumber(field:String, param:String):Number;
		
		function getFieldParam(field:String, param:String):String;
		
		
	}
}