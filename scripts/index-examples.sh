#!/bin/bash

for f in ../exampledocs/*.json; do
	echo "indexing: $f"
	./update-index.sh "$f"
done
