package org.apache.solr.client.solras
{
	public class FacetParams
	{
		/**
   * Should facet counts be calculated?
   */
  public static const  FACET :String= "facet";
  
  /**
   * Any lucene formated queries the user would like to use for
   * Facet Constraint Counts (multi-value)
   */
  public static const  FACET_QUERY :String= FACET + ".query";
  /**
   * Any field whose terms the user wants to enumerate over for
   * Facet Constraint Counts (multi-value)
   */
  public static const  FACET_FIELD :String= FACET + ".field";

  /**
   * The offset into the list of facets.
   * Can be overridden on a per field basis.
   */
  public static const  FACET_OFFSET :String= FACET + ".offset";

  /**
   * Numeric option indicating the maximum number of facet field counts
   * be included in the response for each field - in descending order of count.
   * Can be overridden on a per field basis.
   */
  public static const  FACET_LIMIT :String= FACET + ".limit";

  /**
   * Numeric option indicating the minimum number of hits before a facet should
   * be included in the response.  Can be overridden on a per field basis.
   */
  public static const  FACET_MINCOUNT :String= FACET + ".mincount";

  /**
   * Boolean option indicating whether facet field counts of "0" should 
   * be included in the response.  Can be overridden on a per field basis.
   */
  public static const  FACET_ZEROS :String= FACET + ".zeros";

  /**
   * Boolean option indicating whether the response should include a 
   * facet field count for all records which have no value for the 
   * facet field. Can be overridden on a per field basis.
   */
  public static const  FACET_MISSING :String= FACET + ".missing";

  /**
   * Boolean option:String true causes facets to be sorted
   * by the count, false results in natural index order.
   */
  public static const  FACET_SORT :String= FACET + ".sort";

  /**
   * Only return constraints of a facet field with the given prefix.
   */
  public static const  FACET_PREFIX :String= FACET + ".prefix";

 /**
   * When faceting by enumerating the terms in a field,
   * only use the filterCache for terms with a df >:String= to this parameter.
   */
  public static const  FACET_ENUM_CACHE_MINDF :String= FACET + ".enum.cache.minDf";
  /**
   * Any field whose terms the user wants to enumerate over for
   * Facet Contraint Counts (multi-value)
   */
  public static const  FACET_DATE :String= FACET + ".date";
  /**
   * Date string indicating the starting point for a date facet range.
   * Can be overriden on a per field basis.
   */
  public static const  FACET_DATE_START :String= FACET_DATE + ".start";
  /**
   * Date string indicating the endinging point for a date facet range.
   * Can be overriden on a per field basis.
   */
  public static const  FACET_DATE_END :String= FACET_DATE + ".end";
  /**
   * Date Math string indicating the interval of sub-ranges for a date
   * facet range.
   * Can be overriden on a per field basis.
   */
  public static const  FACET_DATE_GAP :String= FACET_DATE + ".gap";
  /**
   * Boolean indicating how counts should be computed if the range
   * between 'start' and 'end' is not evenly divisible by 'gap'.  If
   * this value is true, then all counts of ranges involving the 'end'
   * point will use the exact endpoint specified -- this includes the
   * 'between' and 'after' counts as well as the last range computed
   * using the 'gap'.  If the value is false, then 'gap' is used to
   * compute the effective endpoint closest to the 'end' param which
   * results in the range between 'start' and 'end' being evenly
   * divisible by 'gap'.
   * The default is false.
   * Can be overriden on a per field basis.
   */
  public static const  FACET_DATE_HARD_END :String= FACET_DATE + ".hardend";
  /**
   *  indicating what "other" ranges should be computed for a
   * date facet range (multi-value).
   * Can be overriden on a per field basis.
   * @see FacetDateOther
   */
  public static const  FACET_DATE_OTHER :String= FACET_DATE + ".other";

	}
}