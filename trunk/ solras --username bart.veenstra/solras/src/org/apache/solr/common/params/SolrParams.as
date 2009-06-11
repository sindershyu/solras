package org.apache.solr.common.params
{
	import flash.utils.Dictionary;

	public class SolrParams implements ISolrParams
	{
		public var params:Dictionary = new Dictionary();
		
		public function getParam(param:String):String 
		{
			return params[param] as String;
		}
		
		public function setParam(param:String, value:Object):void
		{ 
			params[param] = value;	
		}
		
		public function getBool(param:String):Boolean 
		{
			return new Boolean(getParam(param));
		}
		
		public function getNumber(param:String):Number
		{
			return new Number(getParam(param));
		}
		
		public function getFieldBool(field:String, param:String):Boolean
		{
			return new Boolean(getFieldParam(field,param));
		}
		
		public function getFieldNumber(field:String, param:String):Number
		{
			return new Number(getFieldParam(field,param));
		}
		
		public function getFieldParam(field:String, param:String):String
		{
			return getParam(getfpname(field,param));
		}
		
		public function getParams(param:String):Array
		{
			return params[param] as Array;
		}
		
		public function getParameterNames():Array
		{
			var result:Array = new Array();
			for (var key:String in params)
			{
				result.push(key);	
			}
			return result; 
		}
		
		protected function getfpname(field:String, param:String):String
		{
			return "f."+field+"."+param;
		}
			
	}
}