#!/bin/bash
docker run \
	-it \
	--rm \
	-v $PWD/deepoc:/opt/deepoc \
	-v $PWD/solr.in.sh:/etc/default/solr.in.sh \
	-p 8983:8983 \
	-e SOLR_HOME=/opt/deepoc \
	-e INIT_SOLR_HOME=yes \
	--name solr \
	solr
