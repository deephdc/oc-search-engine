#!/bin/bash

doc=$1

#"&f=title:/title"\
#"&f=summary:/summary"\

curl 'http://127.0.0.1:8983/solr/open_catalog/update/json/docs'\
'?f=title:/title'\
'&f=id:/sources/dockerfile_repo'\
'&f=summary:/summary'\
'&f=description:/description'\
'&f=keywords:/keywords'\
'&f=license:/license'\
'&f=date_creation:/date_creation'\
	-H 'Content-type:application/json'\
	-d @"$doc"
