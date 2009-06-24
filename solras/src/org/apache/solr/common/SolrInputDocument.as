package org.apache.solr.common
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.common.utils.DateUtils;

	public class SolrInputDocument
	{
		public var documentBoost:Number;
		private var fields:Dictionary;
		private var fieldsIndex:Array;
		
		public function SolrInputDocument()
		{
			documentBoost = 1.0;
			fields = new Dictionary();
			fieldsIndex = new Array();
		}
		
		public function clear():void
		{
			fields = new Dictionary();
		}
		
		public function setField(field:String, value:Object, documentBoost:Number=1.0):void
		{
			var inputField:SolrInputField = new SolrInputField(field);
			inputField.setValue(value,documentBoost);
			fields[field] = inputField;
			fieldsIndex.push(field);			
		}
		
		public function addField(field:String, value:Object, boost:Number=1.0):void 
		{
			var inputField:SolrInputField = getField(field);
			if(inputField == null)
				setField(field,value,boost);
			else
				inputField.addValue(value,boost);
				
		}
		
		public function getField(field:String):SolrInputField
		{
			return fields[field];
		}
		
		public function removeField(field:String):void 
		{
			fields[field] == null;
			fieldsIndex.splice(fieldsIndex.indexOf(field),1);
		}
		
		
		public function getFieldValue(field:String):Object {
			var inputField:SolrInputField = getField(field);
			if(inputField != null)
				return inputField.getFirstValue();
			return null;
		}
		
		public function getFieldValues(field:String):Array 
		{
			var inputField:SolrInputField = getField(field);
			if(inputField != null)
				return inputField.getValues();
			return null;
		}
		
		public function getFieldNames():Array 
		{
			var names:Array = new Array();
			for (var field:String in fields)
				names.push(field);
			return names;
		}
		
		public function getXML():XML
		{
			var xml:XML = <doc boost={this.documentBoost}></doc>;
			for each (var field:String in fieldsIndex)
			{
				var inputField:SolrInputField = fields[field] as SolrInputField;
				if(inputField != null)
				{
					var boost:Number = inputField.boost;
					var name:String = inputField.name;
					for each (var value:Object in inputField.getValues())
					{
						var dateString:String = null;
						if(value is Date)
							value = DateUtils.toW3CDTF(value as Date);
						var x:XML = <field name={name}>{value}</field>;
						if(boost != 1.0)
							x.@boost = boost;
							
						boost = 1.0;
						xml.appendChild(x);
					}
				}
			}
			xml.@boost = documentBoost;
			return xml;	
		}
		
		public function toString():String 
		{
			return "SolrInputDocument["+fields+"]";
		}
	}
}