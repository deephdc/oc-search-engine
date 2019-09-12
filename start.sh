#!/bin/bash
docker run \
	-it \
	--rm \
	-v $PWD/home:/opt/deep \
	-v $PWD/solr.in.sh:/etc/default/solr.in.sh \
	-p 8983:8983 \
	-e SOLR_HOME=/opt/deep \
	--name solr \
	solr
