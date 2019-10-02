# Search engine for the DEEP Open Catalog
This container provides a basic full-text search service for the DEEP Open Catalog. The search service is based on Solr, a well-known and widely used search platform. This container uses the official Solr Docker image.

## Running the container
To download the base image and run the container, execute the `start.sh` script from the base directory:
```bash
./start.sh
```

By default, Solr server will listen on `http://127.0.0.1:8983`. To adjust the port and/or other parameters, edit the `start.sh`.

## Index new DEEP-OC entry
TODO:

## Re-Index existing DEEP-OC entry
TODO:

## Searching DEEP-OC entries
TODO:
