package org.apache.solr.common
{
	

	public class SolrDocumentList extends Array
	{
		public var numFound:Number = 0;
		public var start:Number = 0;
		public var maxScore:Number;
		
		public function toString():String {
    		return "{numFound="+numFound
	            +",start="+start
	            + (!isNaN(maxScore) ? ""+maxScore : "")
	            +",docs="+super.toString()
	            +"}";
  }
	}
}