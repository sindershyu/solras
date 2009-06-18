package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.client.solras.SolrResponse;
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	public class LukeResponse extends SolrResponse
	{
		public var indexInfo:NamedList;
		public var fieldInfo:Dictionary;
		public var fieldInfoType:Dictionary;
		
		public function LukeResponse(callback:Function=null)
		{
			super(callback);
		}

		override public function set response(resp:NamedList) : void
		{
			super.response = resp;
			indexInfo = super.response.getValue("index") as NamedList;
			var schema:NamedList = super.response.getValue("schema") as NamedList;
			var fields:NamedList = super.response.getValue("fields") as NamedList;
			
			if(fields == null && schema != null)
				fields = schema.getValue("fields") as NamedList;
			
			if(fields != null)
			{
				fieldInfo = new Dictionary();
				for each (var entry:NamedListEntry in fields)
				{
					var f:FieldInfo = new FieldInfo(entry.name);
					f.read(entry.value as NamedList);
					fieldInfo[entry.name] = f;
				}				
			}
			
			if(schema != null)
			{
				var fieldTypes:NamedList = schema.getValue("types") as NamedList;
				for each (var e:NamedListEntry in fieldTypes)
				{
					var ft:FieldTypeInfo = new FieldTypeInfo(e.name);
					ft.read(e.value as NamedList);
					fieldInfoType[e.name] = ft;
				}		
			}
				
		}
	}
}