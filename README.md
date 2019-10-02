# Search engine for the DEEP Open Catalog
This container provides a basic full-text search service for the DEEP Open Catalog. The search service is based on Solr, a well-known and widely used search platform. This container uses the official Solr Docker image.

## Running the container
To download the base image and run the container, execute the `start.sh` script from the base directory:
```bash
./start.sh
```

By default, Solr server will listen on `http://127.0.0.1:8983`. To adjust the port and/or other parameters, edit the `start.sh`.

### Indexing new DEEP OC entries and re-indexing the existing ones
To index a new DEEP OC application, you just need to take its `metadata.json` file and send it to Solr to index it. For instance, [MODS's metadata.json](https://github.com/deephdc/DEEP-OC-mods/blob/master/metadata.json). For this purpose, there is a [`update-index.sh`](https://github.com/deephdc/oc-search-engine/blob/master/scripts/update-index.sh) script:

```bash
usage: ./update-index.sh <file>
  file  : JSON file with application metadata
```

This script maps necessary fields from the metadata.json file to Solr schema, so they are properly indexed and later matched against search queries.

#### Required fields in metadata.json
* /sources/dockerfile_repo - this field is used as an unique ID for indexing and re-indexing DEEP OC application
* /title
* /summary
* /description
* /keywords
* /license
* /date_creation

### Searching DEEP OC entries
Solr can recognize many query parameters. The most common are described [here](https://lucene.apache.org/solr/guide/8_1/common-query-parameters.html). To perform a search, start with the following command replacing `${query}` with your own query:
```bash
curl "http://127.0.0.1:8983/solr/open_catalog/select?q=${query}"
```

#### Pagination
Use [`start`](https://lucene.apache.org/solr/guide/8_1/common-query-parameters.html#start-parameter) and [`rows`](https://lucene.apache.org/solr/guide/8_1/common-query-parameters.html#rows-parameter) parameters to control offset and maximum number of results that are returned to client at one time:
```bash
curl "http://127.0.0.1:8983/solr/open_catalog/select?q=${query}&start=${start}&rows=${rows}"
```

## Examples
### Add example entries to the index
```bash
cd scripts/
./index-examples.sh
```
### Search with pagination
Search for any entry and start displaying results on the second page (start=2*rows-1) with 3 results per page (rows=3)
```bash
curl "http://127.0.0.1:8983/solr/open_catalog/select?q=*&start=3&rows=3"
```
