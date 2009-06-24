/*
   Copyright 2009 Bart.Veenstra @ Gmail.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
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