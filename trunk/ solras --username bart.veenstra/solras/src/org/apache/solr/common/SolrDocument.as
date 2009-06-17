package org.apache.solr.common
{
	import flash.utils.Dictionary;

	public class SolrDocument
	{
		public var fields:Dictionary;
		
		public function SolrDocument()
		{
			fields = new Dictionary();
		}
			
		public function getFieldNames():Array
		{
			var a:Array = new Array();
			for (var key:String in fields)
				a.push(key)
			return a;
		}
		
		public function clear():void 
		{
			fields = new Dictionary();
		}
		
		public function removeFields(name:String):void
		{
			fields[name] = undefined;
		}
		
		public function setField(name:String, value:Object):void 
		{
			var existing:Object = fields[name];
			if(existing is Array)
			{
				fields[name].push(value);
				return;
			}
			else if (existing != null)
			{
				var array:Array = new Array();
				array.push(existing);
				array.push(value);
				fields[name] = array;
				return;
			} else
			{
				fields[name] = value;
			}
		}
		
		public function addField(name:String, value:Object):void 
		{
			setField(name,value);
		}
		
		public function getFirstValue(name:String):Object 
		{
			var value:Object = fields[name];
			
			if(value != null && value is Array)
				return (value as Array)[0];
			else return value; 
		}
		
		public function getFieldValue(name:String):Object
		{
			return fields[name];
		}
		
		public function getFieldValues(name:String):Array
		{
			var value:Object = fields[name];
			if(value != null && value is Array)
				return (value as Array);
			else return new Array(value); 
		}
		
		public function toString():String
		{
			return "SolrDocument["+fields.toString()+"]";
		}
		
		
		
	}
}