package org.apache.solr.common.params
{
	public class UpdateParams
	{
			
		/** wait till the command has flushed */
		public static const WAIT_FLUSH:String 				= "waitFlush";
		  
		/** wait for the search to warm up */
		public static const WAIT_SEARCHER:String 			= "waitSearcher";
		  
		/** overwrite indexing fields */
		public static const OVERWRITE:String 				= "overwrite";
		  
		/** Commit everything after the command completes */
		public static const COMMIT:String 					= "commit";
		  
		/** Commit everything after the command completes */
		public static const OPTIMIZE:String 				= "optimize";
		
		/** Select the update processor to use.  A RequestHandler may or may not respect this parameter */
		public static const UPDATE_PROCESSOR:String 		= "update.processor";
		/**
		 * If optimizing, set the maximum number of segments left in the index after optimization.  1 is the default (and is equivalent to calling IndexWriter.optimize() in Lucene).
		 */
		public static const MAX_OPTIMIZE_SEGMENTS:String 	= "maxSegments";
	}
}