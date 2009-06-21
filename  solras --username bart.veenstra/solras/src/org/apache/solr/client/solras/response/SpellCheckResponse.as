package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	public class SpellCheckResponse
	{
		public var correctlySpelled:Boolean;
		public var collation:String;
		public var suggestions:Array;
		public var suggestionMap:Dictionary;
		
		public function SpellCheckResponse(spellInfo:NamedList)
		{
			var sugg:NamedList = spellInfo.getValue("suggestions") as NamedList;
			if(sugg == null)
			{
				correctlySpelled = true;
				return;
			}
			for each (var entry:NamedListEntry in sugg.children)
			{
				var name:String = entry.name;
				if(name == "correctlySpelled") 
				{
					correctlySpelled = entry.value as Boolean;
				} 
				else if (name == "collation")
				{
					collation = entry.value as String;
				}
				else 
				{
					var s: Suggestion = new Suggestion(name,entry.value as NamedList);
					suggestions.push(s);
					suggestionMap[name] = s;
				}
			}
		}
	}
}