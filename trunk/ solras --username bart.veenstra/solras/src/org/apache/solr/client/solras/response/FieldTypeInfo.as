package org.apache.solr.client.solras.response
{
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	public class FieldTypeInfo
	{
		public var name:String;
		public var className:String;
		public var tokenized:Boolean;
		public var analyzer:String;
		public var fields:Array;
		
		public function FieldTypeInfo(name:String)
		{
			this.name = name;
			
		}
		
		public function read(nl:NamedList):void
		{
			for each (var entry:NamedListEntry in nl)
			{
				switch(entry.name)
				{
					case "fields": 
						fields = entry.value as Array;
						break;
					case "tokenized":
						tokenized = new Boolean(entry.value);
						break;
					case  "analyzer": 
						analyzer = new String(entry.value);
						break;
					case "className":
						className  = new String(entry.value);
						break;
				}
			}
		}
	}
}