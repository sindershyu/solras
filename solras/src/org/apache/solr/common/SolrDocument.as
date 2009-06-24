package org.apache.solr.common
{
	import org.apache.solr.common.utils.NamedList;

	public class SolrDocument extends NamedList
	{
		public function SolrDocument()
		{
			name = "Document";
		}
	
		public function get value():String
		{
			return super.toString();
		}
		
		override public function toString():String
		{
			return "SolrDocument["+super.toString()+"]";
		}
	}
}