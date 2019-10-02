# Search engine for the DEEP Open Catalog
This container provides a basic full-text search service for the DEEP Open Catalog. The search service is based on Solr, a well-known and widely used search platform. This container uses the official Solr Docker image.

## Running the container
To download the base image and run the container, execute the `start.sh` script from the base directory:
```bash
./start.sh
```

By default, Solr server will listen on `http://127.0.0.1:8983`. To adjust the port and/or other parameters, edit the `start.sh`.

## Indexing new DEEP OC entries and re-indexing the existing ones
To index a new DEEP OC application, you just need to take its `metadata.json` file and send it to Solr to index it. For instance, [MODS's metadata.json](https://github.com/deephdc/DEEP-OC-mods/blob/master/metadata.json). For this purpose, there is a `scripts/update-index.sh` script:

```bash
usage: ./update-index.sh <file>
  file  : JSON file with application metadata
```

This script maps necessary fields from the metadata.json file to Solr schema, so they are properly indexed and later matched against search queries.

## Searching DEEP OC entries
TODO:
