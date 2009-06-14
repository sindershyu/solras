package org.apache.solr.client.solras
{
	import mx.utils.ObjectUtil;
	
	import org.apache.solr.common.params.CommonParams;
	import org.apache.solr.common.params.SolrParams;
	
	public class SolrQuery extends SolrParams
	{
		public static const DESC:String = "desc";
		public static const ASC:String = "asc";
		
		
		public function SolrQuery(q:String=null)
		{
			if(q != null)
				setParamValue(CommonParams.Q,q);
		}
		
		public function addFacetField(field:String):SolrQuery
		{
			addParam(FacetParams.FACET_FIELD,field);
			setParamValue(FacetParams.FACET,"true");	
			return this;
		}
		
		public function getFacetFields():Array
		{
			return getParams(FacetParams.FACET_FIELD);
		}
		
		public function removeFacetField(field:String):void
		{
			removeValue(FacetParams.FACET_FIELD,field);
		}
		
		public function setFacet(facet:Boolean):SolrQuery
		{
			if(facet)
			{
				setParamValue(FacetParams.FACET,"true");
			}
			else 
			{
				this.remove(FacetParams.FACET);
				this.remove(FacetParams.FACET_MINCOUNT);
				this.remove(FacetParams.FACET_FIELD);
				this.remove(FacetParams.FACET_LIMIT);
				this.remove(FacetParams.FACET_MISSING);
				this.remove(FacetParams.FACET_OFFSET);
				this.remove(FacetParams.FACET_PREFIX);
				this.remove(FacetParams.FACET_QUERY);
				this.remove(FacetParams.FACET_SORT);
				this.remove(FacetParams.FACET_ZEROS);
				this.remove(FacetParams.FACET_PREFIX); 
			}
			return this;
		} 
		
		public function setFacetPrefix(prefix:String, field:String=null):SolrQuery 
		{
			if(field == null)
				setParamValue(FacetParams.FACET_PREFIX,prefix);
			else 
				this.setParamValue( "f."+field+"."+FacetParams.FACET_PREFIX, prefix );
			return this;
		}
		
		public function addFacetQeury(q:String):SolrQuery
		{
			addParam(FacetParams.FACET_QUERY,q);
			return this;
		}
		
		public function getFacetQueries():Array
		{
			return getParams(FacetParams.FACET_QUERY);
		}
		
		public function removeFacetQuery(q:String):void 
		{
			removeValue(FacetParams.FACET_QUERY,q);
			if(getParams(FacetParams.FACET_QUERY) != null && getParams(FacetParams.FACET_QUERY).length == 0)
				setParamValue(FacetParams.FACET,"false");
		}
		
		public function setFacetMinCount(count:Number):SolrQuery
		{
			setParamValue(FacetParams.FACET_MINCOUNT,count.toString());
			return this;
		}
		
		public function setMissing(field:String):SolrQuery
		{
			setParamValue(FacetParams.FACET_MISSING,"true");
			return this;
		}
		
		public function setFacetSort(sort:Boolean):SolrQuery
		{
			setParamValue(FacetParams.FACET_SORT,sort.toString());
			return this;
		}
		
		public function getFacetSort():Boolean
		{
			return getBool(FacetParams.FACET_SORT);
		}
		
		public function addHighlightField(field:String):SolrQuery
		{
			addParam(HighlightParams.FIELDS,field);
			setParamValue(HighlightParams.HIGHLIGHT,"true");
			return this;
		}
		
		public function removeHighlightField(field:String):void
		{
			removeValue(HighlightParams.FIELD_MATCH,field);
			if(getParams(HighlightParams.FIELD_MATCH) != null && getParams(HighlightParams.FIELD_MATCH).length == 0)
				setParamValue(HighlightParams.FIELD_MATCH,"false");
		}
		
		public function getHighlightFields():Array
		{
			return getParams(HighlightParams.FIELDS);
		}
		
		public function getHighlightSnippets():Number
		{
			return getNumber(HighlightParams.SNIPPETS);
		}
		
		public function setHighlightSnippets(snippets:Number):SolrQuery
		{
			setParamValue(HighlightParams.SNIPPETS,snippets.toString());
			return this;
		}
		
		public function setHighlightFragsize(size:Number):SolrQuery
		{
			setParamValue(HighlightParams.FRAGSIZE,size.toString());
			return this;
		}
		
		public function getHighlightFragsize():Number
		{
			return getNumber(HighlightParams.FRAGSIZE);
		}
		
		public function setHighlightRequireFieldMatch(flag:Boolean):SolrQuery 
		{
			setParamValue(HighlightParams.FIELD_MATCH, flag.toString());
			return this;
		}
		
		public function getHighlightRequireFieldMatch():Boolean
		{
			return this.getBool(HighlightParams.FIELD_MATCH, false);
		}
		
		public function setHighlightSimplePre(f:String):SolrQuery {
			this.setParamValue(HighlightParams.SIMPLE_PRE, f);
			return this;
		}
		
		public function getHighlightSimplePre():String
		{
			return this.getParam(HighlightParams.SIMPLE_PRE, "");
		}
		
		public function setHighlightSimplePost(f:String):SolrQuery 
		{
			this.setParamValue(HighlightParams.SIMPLE_POST, f);
			return this;
		}
		
		public function getHighlightSimplePost():String {
			return this.getParam(HighlightParams.SIMPLE_POST, "");
		}
		
		public function getHighlight():Boolean
		{
			return getBool(HighlightParams.HIGHLIGHT,false);
		}
		
		public function setHighlight(b:Boolean):SolrQuery
		{
			if(b)
			{
				setParamValue(HighlightParams.HIGHLIGHT,b.toString());	
			} 
			else 
			{
				this.remove(HighlightParams.HIGHLIGHT);
				this.remove(HighlightParams.FIELD_MATCH);
				this.remove(HighlightParams.FIELDS);
				this.remove(HighlightParams.FORMATTER);
				this.remove(HighlightParams.FRAGSIZE);
				this.remove(HighlightParams.SIMPLE_POST);
				this.remove(HighlightParams.SIMPLE_PRE);
				this.remove(HighlightParams.SNIPPETS);	
			}
			return this;
		}
		
		public function setFields(fields:Array):SolrQuery
		{
			if(fields == null || fields.length == 0) 
			{
				remove(CommonParams.FL);
			}	
			setParamValue(CommonParams.FL, fields.toString());
			return this;
		}
		
		public function addField(field:String):SolrQuery
		{
			addValueToParam(CommonParams.FL, field);
			return this;
		}
		
		public function getFields():Array
		{
			var fields:String = getParam(CommonParams.FL);
			if(fields != null && fields == "score")
			{
				fields = "*, score";
			}
			return fields.split(",");
		}
		
		public function setIncludeScore(includeScore:Boolean):SolrQuery
		{
			if(includeScore)
				addParam(CommonParams.FL,"score");
			else
				removeValue(CommonParams.FL, "score");
			return this;
		}
		
		public function setSortField(field:String, order:String):SolrQuery 
		{
			this.remove(CommonParams.SORT);
			addValueToParam(CommonParams.SORT, toSortString(field, order));
			return this;
		}
		
		public function addSortField(field:String, order:String):SolrQuery 
		{
			return addValueToParam(CommonParams.SORT, toSortString(field, order));
			return this;
		}
		
		public function removeSortField(field:String, order:String):SolrQuery
		{
			var s:String = getParam(CommonParams.SORT);
			var removeSort:String = toSortString(field, order);
			if(s != null)
			{
				var sorts:Array = s.split(",");
				s = join(sorts.toString(),", ", removeSort);
				if(s.length == 0)
					s = null;
				setParamValue(CommonParams.SORT,s);
			}
			return this; 
		}
		
		public function getSortFields():Array
		{
			var result:String = getParam(CommonParams.SORT);
			if(result != null)
				return result.split(",");
			return null;
		}
		
		public function setFilterQueries(fq:Array):SolrQuery 
		{
			setParam(CommonParams.FQ,fq);
			return this;
		}
		
		public function addFilterQueries(fq:String):SolrQuery
		{
			addParam(CommonParams.FQ,fq);
			return this;
		}
		
		public function removeFilterQuery(fq:String):void 
		{
			removeValue(CommonParams.FQ,fq);
		}
		
		public function getFilterQueries():Array
		{
			return getParams(CommonParams.FQ);
		}
		
		public function setQuery(q:String):SolrQuery
		{
			setParamValue(CommonParams.Q,q);
			return this;
		}
		
		public function getQuery():String
		{
			return getParam(CommonParams.Q);
		}
		
		public function setRows(rows:Number):SolrQuery
		{
			setParamValue(CommonParams.ROWS,rows.toString());
			return this;
		}
		
		public function geRows():Number
		{
			return getNumber(CommonParams.ROWS);
		}
		
		public function setShowDebugInfo(b:Boolean):SolrQuery
		{
			setParamValue(CommonParams.DEBUG_QUERY,b.toString());
			return this;
		}
		
		public function setStart(start:Number):SolrQuery
		{
			setParamValue(CommonParams.START, start.toString());
			return this;
		}
		
		public function getStart():Number
		{
			return getNumber(CommonParams.START);
		}
		
		public function getQueryType():String
		{
			return getParam(CommonParams.QT);
		}
		
		public function setQueryType(qt:String):SolrQuery
		{
			setParamValue(CommonParams.QT,qt);
			return this;
		}
		
		public function copy():SolrQuery
		{
			return ObjectUtil.copy(this) as SolrQuery;
		}
		
		public function setTimeAllowed(milliSeconds:Number=NaN):SolrQuery
		{
			this.setParamValue(CommonParams.TIME_ALLOWED, milliSeconds.toString());
			return this;
		}
		
		public function getTimeAllowed():Number
		{
			return getNumber(CommonParams.TIME_ALLOWED);
		}
		///////////////////////
		//  Utility functions
		///////////////////////
		
		
		private function toSortString(field:String, order:String):String 
		{
			return field + ' ' + order;
		}
		
		private function addValueToParam(name:String, value:String):SolrQuery 
		{
			var tmp:String = this.getParam(name);
			tmp = join(tmp, value, ",");
			this.setParamValue(name, tmp);
			return this;
		}
		
		private function join(a:String, b:String, sep:String):String
		{
			var result:String = "";
			if(a!=null && a.length > 0)
				result += a + sep;
			if(b!=null && b.length > 0)
				result += b;
			
			return b;
		}
	}
}