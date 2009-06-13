package org.apache.solr.client.solras.response
{
	

	public class FacetField
	{
		public var name:String;
		public var values:Array;
		public var gap:String;
		public var end:Date;
		
		public function FacetField(name:String,gap:String=null,end:Date=null)
		{
			this.name = name;
			this.gap = gap;
			this.end = end;
		}
		
		public function add(name:String, count:Number):void
		{
			if(values == null)
				values = new Array();
				
			values.push(new FacetFieldCount(name,count,this));
		}
		
		public function insert(name:String, count:Number):void 
		{
			if(values == null)
				values = new Array();
				
			values.unshift(new FacetFieldCount(name,count,this));
		}
		
		public function getValueCount():Number
		{
				return values != null ? values.length : 0;
		}
		
		public function getLimitingFields(max:Number):FacetField
		{
			var facetField:FacetField = new FacetField(name);
			if(values!=null)
			{
				facetField.values = new Array();
				for each (var count:FacetFieldCount in values)
				{
					if(count.count < max)
						facetField.add(count.name,count.count);
				}
			}
			return facetField;
				
		}
		
		public function toString():String
		{
			return name + ":" + values.toString();
		}
		
	}
}