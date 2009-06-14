package org.apache.solr.client.solras.response
{
	import flash.xml.XMLNode;
	
	import org.apache.solr.common.utils.NamedList;

	public class ResponseProcessor
	{
		public static function process(xml:XMLNode):NamedList
		{
			trace(xml.toString());
			
			return null;
		}
	}
}