This library will enable flash and flex developers to use the Solr indexing server. It is based on the SolrJ API.

# Setup #
Include the solras library to your flex 3.0 or higher project

# Download #
Please check out the library from SVN because it is still pretty much Alpha...

# Usage #

## Query ##
```
var client:SolrClient = new SolrClient("http://localhost:9080/solr/");
var q:SolrQuery = new SolrQuery("[* TO *]");
var solrResponse:SolrResponse = client.query(q, searchResultHandler);


protected function searchResultHandler(solrResponse:SolrResponse):void 
{
   // do something with the result like below
   // only one doc in the index....
}
```
### Result ###
![http://phonetech.nl/beartcommons/basic%20query%20result.png](http://phonetech.nl/beartcommons/basic%20query%20result.png)
