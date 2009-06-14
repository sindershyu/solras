package org.apache.solr.common.params
{
	import flash.utils.Dictionary;

	public class SolrParams
	{
		private var params:Dictionary = new Dictionary();
		private var paramIndex:Array = new Array();
		
		public function getParam(name:String, def:String=null):String 
		{
			var value:Array = params[name] as Array;
			if(value == null)
				return def;
			return value[0];
		}
		
		public function setParam(name:String, value:Array):SolrParams
		{ 
			params[name] = value;	
			paramIndex.push(name);
			return this;
		}
		
		public function setParamValue(name:String, value:String):SolrParams
		{
			return setParam(name,[value]);
		}
		
		public function addParam(name:String, value:String):SolrParams
		{
			var p:Array = params[name] as Array;
			if(p == null)
			{
				setParam(name,[value]);
				return this;
			}
			
			p.push(value);
			return this;
		}
		
		public function add(solrParams:SolrParams):void
		{
			for each (var name:String in solrParams.getParameterNames())
			{
				setParam(name,solrParams.getParams(name));
			}
			
		}
		
		public function remove(name:String):void
		{
			params[name] = undefined;
			paramIndex.slice(paramIndex.indexOf(name),1);
		}
		
		public function removeValue(name:String, value:String):void
		{
			var values:Array = getParams(name);
			if(values == null)
				return;
			values.slice(values.indexOf(value),1);
		}
		
		
		public function getBool(name:String, def:Boolean=false):Boolean 
		{
			if(getParam(name) == null)
				return def;
			return new Boolean(getParam(name));
		}
		
		public function getNumber(name:String):Number
		{
			return new Number(getParam(name));
		}
		
		public function getFieldBool(field:String, name:String):Boolean
		{
			return new Boolean(getFieldParam(field,name));
		}
		
		public function getFieldNumber(field:String, name:String):Number
		{
			return new Number(getFieldParam(field,name));
		}
		
		public function getFieldParam(field:String, name:String):String
		{
			return getParam(getfpname(field,name));
		}
		
		public function getParams(name:String):Array
		{
			return params[name] as Array;
		}
		
		public function getParameterNames():Array
		{
			return paramIndex;
		}
		
		protected function getfpname(field:String, name:String):String
		{
			return "f."+field+"."+name;
		}
			
	}
}