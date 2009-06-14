package org.apache.solr.client.solras
{
	public class HighlightParams
	{
		 public static const  HIGHLIGHT   :String = "hl";
  public static const  FIELDS      :String = HIGHLIGHT+".fl";
  public static const  SNIPPETS    :String = HIGHLIGHT+".snippets";
  public static const  FRAGSIZE    :String = HIGHLIGHT+".fragsize";
  public static const  INCREMENT   :String = HIGHLIGHT+".increment";
  public static const  MAX_CHARS   :String = HIGHLIGHT+".maxAnalyzedChars";
  public static const  FORMATTER   :String = HIGHLIGHT+".formatter";
  public static const  FRAGMENTER  :String = HIGHLIGHT+".fragmenter";
  public static const  FIELD_MATCH :String = HIGHLIGHT+".requireFieldMatch";
  public static const  ALTERNATE_FIELD :String = HIGHLIGHT+".alternateField";
  public static const  ALTERNATE_FIELD_LENGTH :String = HIGHLIGHT+".maxAlternateFieldLength";
  
  public static const  USE_PHRASE_HIGHLIGHTER :String = HIGHLIGHT+".usePhraseHighlighter";

  public static const  MERGE_CONTIGUOUS_FRAGMENTS :String = HIGHLIGHT + ".mergeContiguous";
  // Formatter
  public static const  SIMPLE :String = "simple";
  public static const  SIMPLE_PRE  :String = HIGHLIGHT+"."+SIMPLE+".pre";
  public static const  SIMPLE_POST :String = HIGHLIGHT+"."+SIMPLE+".post";

  // Regex fragmenter
  public static const  REGEX :String = "regex";
  public static const  SLOP  :String = HIGHLIGHT+"."+REGEX+".slop";
  public static const  PATTERN  :String = HIGHLIGHT+"."+REGEX+".pattern";
  public static const  MAX_RE_CHARS   :String = HIGHLIGHT+"."+REGEX+".maxAnalyzedChars";
	}
}