package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	internal class Suggestion
	{
		public var token:String;
    	public var numFound:Number;
    	public var startOffset:Number;
    	public var endOffset:Number;
    	public var originalFrequency:Number;
    	public var suggestions:Array = new Array();
    	public var suggestionFrequencies:Array = new Array();
		
		public function Suggestion(token:String,suggestion:NamedList)
		{
			this.token = token;
			for each (var entry:NamedListEntry in suggestion)
			{
				var n:String =  entry.name;
				if(n == "numFound")
					numFound = entry.value as Number;
				else if (n == "startOffset")
					startOffset = entry.value as Number;
				else if (n == "endOffset")
					endOffset = entry.value as Number;
				else if (n == "origFreq")
					originalFrequency = entry.value as Number;
				else if (n == "suggestion")
				{
					var o:Object = entry.value;
					if(o is Array)
						suggestions.push(o as Array);
					else if (o is Dictionary)
					{
						suggestions.push(o["word"]);
						suggestionFrequencies.push(o["frequency"] as Number);	
					}
				}
			}	
		}
	}
}