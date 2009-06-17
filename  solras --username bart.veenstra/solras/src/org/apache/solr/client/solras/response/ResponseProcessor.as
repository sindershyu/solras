package org.apache.solr.client.solras.response
{
	
	import org.apache.solr.common.SolrDocument;
	import org.apache.solr.common.SolrDocumentList;
	import org.apache.solr.common.SolrInputDocument;
	import org.apache.solr.common.utils.NamedList;

	public class ResponseProcessor
	{
		
		//public var knownTypes:Array = ["str","int","float", "double", "long","bool","null","date","arr","lst","result","doc"];
		public static const STR:String = "str";
		public static const INT:String = "int";
		public static const FLOAT:String = "float";
		public static const DOUBLE:String = "double";
		public static const LONG:String = "long";
		public static const BOOL:String = "bool";
		public static const NULL:String = "null";
		public static const DATE:String = "date";
		public static const ARR:String = "arr";
		public static const LST:String = "lst";
		public static const RESULT:String = "result";
		public static const DOC:String = "doc";
		
		public static function process(xml:XML, namedList:NamedList):void
		{
			for each (var child:XML in xml.children())
			{
				var type:String = child.name();
				var name:String = child.@name;
				var value:Object = parseLeaf(type,child);
				namedList.add(name,value);
			}
		}
		
		private static function processNamedList(xml:XML):NamedList 
		{
			var namedList:NamedList = new NamedList();
			for each (var child:XML in xml.children())
			{
				var type:String = child.name();
				var name:String = child.@name;
				var value:Object = parseLeaf(type,child);
				namedList.add(name,value);
				
			}
			return namedList;
		}
		
		private static function parseLeaf(type:String,value:Object):Object
		{
			trace(type);
			var result:Object = null;
			switch(type)
			{
				case STR:
					result = value.toString();
					break;
				case INT:
				case FLOAT:
				case DOUBLE:
				case LONG:
					result = new Number(value.toString());
					break;
				case BOOL:
					result = new Boolean(value.toString());
					break;
				case NULL:
					result = null;
					break;
				case DATE:
					result = parseUTCDate(value.toString());
					break;
				case ARR:
					result = processArray(value as XML);
					break;
				case LST:
					result = processNamedList(value as XML);
					break;
				case RESULT:
					result = processResult(value as XML);
					break;
				case DOC:
					result = processDoc(value as XML);
					break;
			}
			return result;
		}
		
		private static function processResult(xml:XML):SolrDocumentList
		{
			var list:SolrDocumentList = new SolrDocumentList();
			list.numFound = xml.@numFound;
			list.maxScore = xml.@maxScore;
			list.start = xml.@start;
			
			for each(var doc:XML in xml.doc)
			{
				var solrInputDocument:SolrDocument = processDoc(doc);
				list.push(solrInputDocument);
			}			
			return list;
		}
		
		private static function processDoc(xml:XML):SolrDocument
		{
			var doc:SolrDocument = new SolrDocument();
			for each (var child:XML in xml.children())
			{
				var type:String = child.name();
				var result:Object = parseLeaf(type,child.valueOf());
				var name:String = child.@name;
				doc.addField(name,result);
			}
			
			return doc;
		}
		private static function processArray(xml:XML):Array
		{
			var array:Array = new Array();
			for each (var child:XML in xml.children())
			{
				var type:String = child.name();
				var result:Object = parseLeaf(type,child.valueOf()); 
				array.push(result);	
			}
			return array;
		}
		
		
		private static function parseUTCDate( str : String ) : Date {
			var matches:Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)|.(\d?)|Z/);
    		var d : Date = new Date();
    		d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
    		d.setUTCHours(int(matches[4]), int(matches[5]), int(matches[6]), 0);
    		return d;
		}
	}
}