package org.apache.solr.common.params
{
	public class CommonParams
	{
		/** the query type - which query handler should handle the request */
		public static const  QT :String ="qt";
		  
		/** the response writer type - the format of the response */
		public static const  WT :String ="wt";
		  
		/** query  */
		public static const  Q :String ="q";
		  
		/** sort order */
		public static const  SORT :String ="sort";
		  
		/** Lucene query (s) for filtering the results without affecting scoring */
		public static const  FQ :String ="fq";
		  
		/** zero based offset of matching documents to retrieve */
		public static const  START :String ="start";
		  
		/** number of documents to return starting at "start" */
		public static const  ROWS :String ="rows";
		  
		/** stylesheet to apply to XML results */
		public static const  XSL :String ="xsl";
		  
		/** stylesheet to apply to XML results */
		public static const  VERSION :String ="version";
		  
		/** query and init param for field list */
		public static const  FL :String = "fl";
		  
		/** default query field */
		public static const  DF :String = "df";
		  
		/** whether to include debug data */
		public static const  DEBUG_QUERY :String = "debugQuery";
		  
		/** another query to explain against */
		public static const  EXPLAIN_OTHER :String = "explainOther";
		  
		
		/** If the content stream should come from a URL (using URLConnection) */
		public static const  STREAM_URL :String = "stream.url";
		
		/** If the content stream should come from a File (using FileReader) */
		public static const  STREAM_FILE :String = "stream.file";
		  
		/** If the content stream should come directly from a field */
		public static const  STREAM_BODY :String = "stream.body";
		  
		/** 
		 * Explicitly set the content type for the input stream
		 * If multiple streams are specified, the explicit contentType
		 * will be used for all of them.  
		 */
		public static const  STREAM_CONTENTTYPE :String = "stream.contentType";
		  
		/**
		 * Timeout value in milliseconds.  If not set, or the value is <:String = 0, there is no timeout.
		 */
		public static const  TIME_ALLOWED :String = "timeAllowed";
		  
		/** 'true' if the header should include the handler name */
		public static const  HEADER_ECHO_HANDLER :String = "echoHandler";
		  
		/** include the parameters in the header **/
		public static const  HEADER_ECHO_PARAMS :String = "echoParams";
		}
}