package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.common.SolrDocumentList;
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;
	import org.apache.solr.client.solras.SolrResponse;

	public class QueryResponse extends SolrResponse
	{
		
		// Direct pointers to known types
		private var header:NamedList;
		private var results:SolrDocumentList;
		private var sortValues:NamedList;
		private var facetInfo:NamedList;
		private var debugInfo:NamedList;
		private var highlighting:NamedList;
		private var spellInfo:NamedList;
		
		// Facet stuff
		private var facetQuery:Dictionary;
		private var facetFields:Array;
		private var limitingFacets:Array;
		private var facetDates:Array;
		
		// Highlight Info
		private var highLighting:Dictionary;
		
		// Spellcheck response
		private var  spellResponse:SpellCheckResponse;
		
		// Debug Info
		private var debugMap:Dictionary;
		private var explainMap:Dictionary;
		
		// utility variable used for automatic binding -- it should not be serialized
		private  var solrClient:SolrClient;

		public function QueryResponse(response:NamedList=null,solrClient:SolrClient=null)
		{
			super();
			super.response = response;
			this.solrClient = solrClient;
		}
		
		override public function set response(response:NamedList) : void
		{
			super.response = response;
			for each (var entry:NamedListEntry in response)
			{
				var name:String = entry.name;
				if(name == "responseHeader")
				{	
					header = entry.value as NamedList;		
				}
				else if(name == "response")
				{
					results = entry.value as SolrDocumentList;
				}
				else if(name == "sort_values")
				{
					sortValues = entry.value as NamedList;
				}
				else if(name == "facet_counts")
				{
					facetInfo = entry.value as NamedList;
					extractFacetInfo(facetInfo);
				}
				else if(name == "debug") 
				{
					debugInfo = entry.value as NamedList;
					extractDebugInfo(debugInfo);
				}
				else if(name == "highlighting")
				{
					highlighting = entry.value as NamedList;
					extractHighlightingInfo(highlighting);
				}
				else if(name == "spellcheck")
				{
					spellInfo = entry.value as NamedList;
					extractSpellCheckInfo(spellInfo);
				}
			}				 	
		}
		
		private function extractDebugInfo(debug:NamedList):void
		{
			debugMap = new Dictionary();
			putNamedListToMap(debug,debugMap);
			explainMap = new Dictionary();
			var info:NamedList = debugInfo.getValue("explain") as NamedList;
			if(info != null)
			{
				putNamedListToMap(info,explainMap);
			}
		}
		
		private function putNamedListToMap(nl:NamedList, map:Dictionary):void
		{
			for each (var entry:NamedListEntry in nl.entries)
			{
				map[entry.name] = entry.value;
			}
		}
		
		private function extractHighlightingInfo(info:NamedList):void
		{
			highLighting = new Dictionary();
			for each (var entry:NamedListEntry in info.entries)
			{
				highlighting[entry.name] = new Dictionary();
				var fnl:NamedList = entry.value as NamedList;
				putNamedListToMap(fnl,highlighting[entry.name] as Dictionary);
			}
		}
		
		private function extractFacetInfo(info:NamedList):void
		{
			facetQuery = new Dictionary();
			var fq:NamedList = info.getValue("facet_queries") as NamedList;
			putNamedListToMap(fq,facetQuery);
			
			var ff:NamedList = info.getValue("facet_fields") as NamedList;
			if(ff!=null)
			{
				facetFields = new Array();
				limitingFacets = new Array();
				
				var minSize:Number = results.numFound;
				for each (var facet:NamedListEntry in ff)
				{
					var f:FacetField = new FacetField(facet.name);
					for each (var entry:NamedListEntry in facet.value as NamedList)
						f.add(facet.name, facet.value as Number);
					facetFields.push(f);
					
					var nl:FacetField = f.getLimitingFields(minSize);
					if(nl.getValueCount() > 0)
						limitingFacets.push(nl);
				}
			}
			
			var df:NamedList = info.getValue("facet_dates") as NamedList;
			if(df!=null)
			{
				facetDates = new Array();
				for each (var dateFacet:NamedListEntry in df)
				{
					var values:NamedList = dateFacet.value as NamedList;
					var gap:String = values.getValue("gap") as String;
					var end:Date = values.getValue("end") as Date;
				
					var dateField:FacetField = new FacetField(dateFacet.name, gap,end);
					for each (var dateEntry:NamedListEntry in dateFacet.value as NamedList)
					{
						if(dateEntry.value is Number)
							dateField.add(dateEntry.name, dateEntry.value as Number);
					}
					facetDates.push(dateField);
				}
			}
			
		}
		
		private function removeFacets():void 
		{
			facetFields = new Array();
		}
		
		private function extractSpellCheckInfo(info:NamedList):void
		{
			spellResponse = new SpellCheckResponse(info);
		}
		
		private function getFacetField(name:String):FacetField
		{
			if(facetFields == null)
				return null;
			for each (var f:FacetField in  facetFields)
			{	
				if(f.name == name)
					return f;
			}
			return null;
		}
		
		private function getFacetDate(name:String):FacetField
		{
			if(facetDates == null)
				return null;
			for each (var f:FacetField in facetDates)
			{	
				if(f.name == name)
					return f;
			}
			return null;
		}
	}
}