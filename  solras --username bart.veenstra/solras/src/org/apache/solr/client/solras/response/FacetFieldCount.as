package org.apache.solr.client.solras.response
{
	public class FacetFieldCount
	{
		public var name:String;
		public var count:Number;
		public var facetField:FacetField;
		
		public function FacetFieldCount(name:String,count:Number,facetField:FacetField)
		{
			this.name = name;
			this.count = count;
			this.facetField = facetField;
		}
		
		public function toString():String
		{
			return name +  "(" + count + ")";
		}
		
		public function getAsFilterQuery():String {
			if(facetField.name == "facet_queries")
				return name;
				
			var p1:RegExp = new RegExp("(\\W)");
			var p2:RegExp = new RegExp("\\\\$1");
			return facetField.name.replace(p1,p2) + ":" + name.replace(p1,p2);
		}
	}
}