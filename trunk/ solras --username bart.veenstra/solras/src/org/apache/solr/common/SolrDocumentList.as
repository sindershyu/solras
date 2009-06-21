package org.apache.solr.common
{
	

	public class SolrDocumentList
	{
		private var array:Array = new Array();
		
		public var numFound:Number = 0;
		public var start:Number = 0;
		public var maxScore:Number;
		
		public function get name():String 
		{
			return "Search Result";
		}
		
		public function get value():String
		{
			return "Documents found " + numFound + " showing " + array.length + " from " + start;
		}
		
		public function add(doc:SolrDocument):void 
		{
			array.push(doc);
		}
		
		public function get documents():Array
		{
			return array;
		}
		
		public function get length():uint
		{
			return array.length;
		}
		
		
		public function toString():String {
    		return "numFound = "+numFound + " start = " + start + (!isNaN(maxScore) ? ""+maxScore : "");
//	            +",docs="+super
//	            +"}";
  }
	}
}