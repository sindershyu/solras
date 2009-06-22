package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	[Bindable]
	public class FieldInfo
	{
		public var name:String;
		public var type:String;
		public var schema:String;
		public var docs:Number;
		public var distinct:Number;
		public var flags:Array;
		public var cachableFaceting:Boolean;
		public var topTerms:NamedList;
		
		public static var FLAGS:Dictionary = fillFlags();
		
		public static function fillFlags():Dictionary
		{
			var d:Dictionary = new Dictionary();
			d['I']=  new FieldFlag("I","Indexed");
			d['T'] = new FieldFlag("T","Tokenized"); 
			d['S'] = new FieldFlag("S","Stored");
			d['M'] = new FieldFlag("M","Multivalued");
			d['V'] = new FieldFlag("V","TermVector Stored"); 
			d['o'] = new FieldFlag("o","Store Offset With TermVector");
			d['p'] = new FieldFlag("p","Store Position With TermVector");
			d['O'] = new FieldFlag("O","Omit Norms");
			d['L'] = new FieldFlag("L","Lazy");
			d['B'] = new FieldFlag("B","Binary"); 
			d['C'] = new FieldFlag("C","Compressed");
			d['f'] = new FieldFlag("f","Sort Missing First"); 
			d['l'] = new FieldFlag("l","Sort Missing Last");
			return d; 
		}
		
		public function FieldInfo(name:String)
		{
			this.name = name;
		}
		
		public function read(nl:NamedList):void 
		{
			for each (var entry:NamedListEntry in nl.children)
			{
				switch(entry.name)
				{
					case "type": type = entry.valueAsString(); break;
					case "flags": flags = parseFlags(entry.valueAsString());break;
					case "schema": schema = entry.valueAsString(); break;
					case "docs": docs = new Number(entry.value); break;
					case "distinct" : distinct = new Number(entry.value); break;
					case "cacheableFaceting" : cachableFaceting = new Boolean(entry.value); break;
					case "topTerms" : entry.value as NamedList; break;
					
				}
			}
		}
		
		public function parseFlags(flagStr:String):Array{
			var result:Array = new Array();
			for(var i:int = 0; i < flagStr.length; i++)
			{
				var flag:String = flagStr.charAt(i);
				if(FLAGS[flag]!=null)
				{
					var fieldFlag:FieldFlag = FieldFlag(FLAGS[flag]);
					result.push(fieldFlag);
				}
			}
			return result;
		}
				
	}
}