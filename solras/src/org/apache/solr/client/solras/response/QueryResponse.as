package org.apache.solr.client.solras.response
{
	import flash.utils.Dictionary;
	
	import org.apache.solr.client.solras.SolrClient;
	import org.apache.solr.client.solras.SolrQuery;
	import org.apache.solr.client.solras.SolrResponse;
	import org.apache.solr.common.SolrDocumentList;
	import org.apache.solr.common.params.SolrParams;
	import org.apache.solr.common.utils.NamedList;
	import org.apache.solr.common.utils.NamedListEntry;

	public class QueryResponse extends SolrResponse
	{
		
		// Direct pointers to known types
		[Bindable] public var header:NamedList;
		[Bindable] public var results:SolrDocumentList;
		[Bindable] public var sortValues:NamedList;
		[Bindable] public var facetInfo:NamedList;
		[Bindable] public var debugInfo:NamedList;
		[Bindable] public var highlighting:NamedList;
		[Bindable] public var spellInfo:NamedList;
		
		// Facet stuff
		[Bindable] public var facetQuery:Dictionary;
		[Bindable] public var facetFields:Array;
		[Bindable] public var limitingFacets:Array;
		[Bindable] public var facetDates:Array;
		
		// Highlight Info
		[Bindable] public var highLighting:Dictionary;
		
		// Spellcheck response
		[Bindable] public var  spellResponse:SpellCheckResponse;
		
		// Debug Info
		[Bindable] public var debugMap:Dictionary;
		[Bindable] public var explainMap:Dictionary;
		
		// utility variable used for automatic binding -- it should not be serialized
		private  var solrClient:SolrClient;
		
		[Bindable] public var requestPending:Boolean = true;

		public function QueryResponse(response:NamedList=null,solrClient:SolrClient=null,callback:Function=null)
		{
			super(callback);
			super.response = response;
			this.solrClient = solrClient;
		}
		
		public function loadFacets():void 
		{
			
		}
		
		public function updateResults(start:Number):void
		{
			requestPending = true;
			var params:NamedList = header.getValue("params") as NamedList;
			var sIndex:Number = params.indexOf("start") as Number;
			if(sIndex == -1)
				params.add("start", start);
			else
				params.setValue(sIndex,start);
			solrClient.query(SolrParams.toSolrParams(params),updateHandler);
		}
		
		public function applyFacet(f:FieldInfo):void 
		{
			requestPending = true;
			var params:NamedList = header.getValue("params") as NamedList;
			var q:SolrQuery = new SolrQuery();
			q.add(SolrParams.toSolrParams(params));
			q.addFacetField(f.name);
			solrClient.query(q,updateHandler);
		}
		
		public function removeFacet(f:FieldInfo):void 
		{
			requestPending = true;
			var params:NamedList = header.getValue("params") as NamedList;
			var q:SolrQuery = new SolrQuery();
			q.add(SolrParams.toSolrParams(params));
			q.removeFacetField(f.name);
			solrClient.query(q,updateHandler);
		}
	
		public function updateHandler(response:QueryResponse):void 
		{
			this.response = response.response;
		}		

		override public function set response(response:NamedList) : void
		{
			super.response = response;
			for each (var entry:NamedListEntry in super.response.children)
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
			requestPending = false;				 	
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
			for each (var entry:NamedListEntry in nl.children)
			{
				map[entry.name] = entry.value;
			}
		}
		
		private function extractHighlightingInfo(info:NamedList):void
		{
			highLighting = new Dictionary();
			for each (var entry:NamedListEntry in info.children)
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
				for each (var facet:NamedListEntry in ff.children)
				{
					var f:FacetField = new FacetField(facet.name);
					var nl:NamedList = facet.value as NamedList;
					for each (var entry:NamedListEntry in nl.children)
						f.add(facet.name, new Number(facet.value));
					facetFields.push(f);
					
					var faf:FacetField = f.getLimitingFields(minSize);
					if(faf.getValueCount() > 0)
						limitingFacets.push(faf);
				}
			}
			
			var df:NamedList = info.getValue("facet_dates") as NamedList;
			if(df!=null)
			{
				facetDates = new Array();
				for each (var dateFacet:NamedListEntry in df.children)
				{
					var values:NamedList = dateFacet.value as NamedList;
					var gap:String = values.getValue("gap") as String;
					var end:Date = values.getValue("end") as Date;
				
					var dateField:FacetField = new FacetField(dateFacet.name, gap,end);
					var nld:NamedList = dateFacet.value as NamedList;
					for each (var dateEntry:NamedListEntry in nld.children )
					{
						dateField.add(dateEntry.name, new Number(dateEntry.value));
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