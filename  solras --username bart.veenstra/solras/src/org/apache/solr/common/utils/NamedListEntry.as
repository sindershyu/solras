package org.apache.solr.common.utils
{
	import mx.utils.ObjectUtil;

	public class NamedListEntry
	{
		public var name:String;
		public var value:Object;
		
		public function NamedListEntry(name:String, value:Object)
		{
			this.name = name;
			this.value = value;
		}
		
		public function valueAsString():String
		{
			return value != null ? value.toString() : null;
		}
		
		public function clone():NamedListEntry
		{
			return ObjectUtil.copy(this) as NamedListEntry;		
		}	
	}
}