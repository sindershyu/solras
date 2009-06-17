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
	/*
	<response>

<lst name="responseHeader">
 <int name="status">0</int>
 <int name="QTime">15</int>
 <lst name="params">
  <str name="explainOther"/>
  <str name="fl">*,score</str>
  <str name="debugQuery">on</str>

  <str name="indent">on</str>
  <str name="start">0</str>
  <str name="q">[* TO *]</str>
  <str name="hl.fl">*</str>
  <str name="qt">standard</str>
  <str name="wt">standard</str>

  <str name="hl">on</str>
  <str name="rows">10</str>
  <str name="version">2.2</str>
 </lst>
</lst>
<result name="response" numFound="1" start="0" maxScore="1.0">
 <doc>
  <float name="score">1.0</float>

  <arr name="cat"><str>eletronics</str><str>hard drive</str></arr>
  <arr name="features"><str>7200RPM, 8MB cache, IDE Ultra ATA-133</str><str>NoiseGuard, SilentSeek technology, Fluid Dynamic Bearing (FDB) motor</str></arr>
  <str name="id">SP2514N</str>
  <bool name="inStock">true</bool>
  <str name="manu">Samsung Electronics Co. Ltd.</str>

  <str name="name">Samsung SpinPoint P120 SP2514N - hard drive - 250 GB - ATA-133</str>
  <int name="popularity">6</int>
  <float name="price">92.0</float>
  <str name="sku">SP2514N</str>
  <arr name="spell"><str>Samsung SpinPoint P120 SP2514N - hard drive - 250 GB - ATA-133</str></arr>
  <date name="timestamp">2009-06-16T18:18:56.816Z</date>

 </doc>
</result>
<lst name="highlighting">
 <lst name="SP2514N"/>
</lst>
<lst name="debug">
 <str name="rawquerystring">[* TO *]</str>
 <str name="querystring">[* TO *]</str>
 <str name="parsedquery">text:[* TO *]</str>

 <str name="parsedquery_toString">text:[* TO *]</str>
 <lst name="explain">
  <str name="SP2514N">
1.0 = (MATCH) ConstantScoreQuery(text:[-}), product of:
  1.0 = boost
  1.0 = queryNorm
</str>
 </lst>
 <str name="QParser">OldLuceneQParser</str>
 <lst name="timing">
  <double name="time">15.0</double>

  <lst name="prepare">
	<double name="time">0.0</double>
	<lst name="org.apache.solr.handler.component.QueryComponent">
	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.FacetComponent">
	 <double name="time">0.0</double>

	</lst>
	<lst name="org.apache.solr.handler.component.MoreLikeThisComponent">
	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.HighlightComponent">
	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.DebugComponent">

	 <double name="time">0.0</double>
	</lst>
  </lst>
  <lst name="process">
	<double name="time">15.0</double>
	<lst name="org.apache.solr.handler.component.QueryComponent">
	 <double name="time">0.0</double>

	</lst>
	<lst name="org.apache.solr.handler.component.FacetComponent">
	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.MoreLikeThisComponent">
	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.HighlightComponent">

	 <double name="time">0.0</double>
	</lst>
	<lst name="org.apache.solr.handler.component.DebugComponent">
	 <double name="time">15.0</double>
	</lst>
  </lst>
 </lst>
</lst>

</response>
*/
}