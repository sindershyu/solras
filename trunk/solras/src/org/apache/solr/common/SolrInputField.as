package org.apache.solr.common
{
	import mx.collections.ArrayCollection;

	public class SolrInputField
	{
		public var name:String;
		public var value:Object;
		public  var boost:Number;
		
		public function SolrInputField(name:String)
		{
			this.name = name;
		}
	
	
		public function setValue(value:Object, boost:Number):void
		{
			this.boost = boost;
			if(value is ArrayCollection)
			{
				this.value = (value as ArrayCollection).toArray();	
			}
			
			this.value = value;
		}
		
		public function addValue(value:Object, boost:Number):void
		{
			if(this.value == null)
			{
				setValue(value,boost);
				return;
			}
			
			if(!(this.value is Array))
				this.value = new Array(this.value);
			
			
			this.boost *= boost;
			(this.value as Array).push(value);
		}
		
		public function getValue():Object { return value; }
		
		public function getValues():Array 
		{ 
			if(value is Array)
				return value as Array;
			else
			{ 
				var result:Array = new Array();
				result.push(value);
				return result;
			}
		
		}
		
		public function getFirstValue():Object 
		{
			if(value is Array)
				return (value as Array)[0];
			else return value; 
		}
		
		public function toString():String
		{
			return name + "(" + boost + ")={" + value + "}";
		} 
		
	 
	}	
	
}