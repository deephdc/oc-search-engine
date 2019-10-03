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
Search for any entry and start displaying results on the second page (`start=2*rows-1`) with 3 results per page (`rows=3`)
```bash
curl "http://127.0.0.1:8983/solr/open_catalog/select?q=*&start=3&rows=3"
```

Result:
```json
{
  "responseHeader":{
    "status":0,
    "QTime":2,
    "params":{
      "q":"*",
      "start":"3",
      "rows":"3"}},
  "response":{"numFound":6,"start":3,"docs":[
      {
        "title":"DEEP OC Speech to Text",
        "summary":"Speech to text using Tensorflow",
        "description":["This is a plug-and-play tool for real-time pose estimation using deep neural networks. The original model, weights, code, etc. was created by Google and can be found at https://github.com/tensorflow/tfjs-models/tree/master/posenet.",
          "PoseNet can be used to estimate either a single pose or multiple poses, meaning there is a version of the algorithm that can detect only one person in an image/video and one version that can detect multiple persons in an image/video.",
          "The module implemented here works on pictures (either uploaded or using an URL) and gives as output the different body keypoints with the corresponding coordinates and the associated key score"],
        "keywords":["services",
          "docker"],
        "license":"Apache 2.0",
        "date_creation":"2019-07-31T00:00:00Z",
        "id":"https://github.com/deephdc/DEEP-OC-posenet-tf",
        "sources_dockerfile_repo":"https://github.com/deephdc/DEEP-OC-posenet-tf",
        "_version_":1646289475989405696},
      {
        "title":"DEEP OC Satellite super resolution",
        "summary":"A trained network to super resolve low resolution bands to high resolution in multispectral satellite imagery.",
        "description":["With the latest missions launched by the European Space Agency (ESA) and National Aeronautics and Space Administration (NASA)",
          "equipped with the latest technologies in multi-spectral sensors, we face an unprecedented amount of data with spatial and",
          "temporal resolutions never reached before. Exploring the potential of this data with state-of-the-art AI techniques like",
          "Deep Learning, could potentially change the way we think about and protect our planet's resources.\n",
          "This Docker container contains  a plug-and-play tool to perform super-resolution on satellite imagery.",
          "It uses Deep Learning to provide a better performing alternative to classical pansharpening (more details in [1]).\n",
          "Right now we are supporting super-resolution for the following satellites:",
          "* [Sentinel 2](https://sentinel.esa.int/web/sentinel/missions/sentinel-2)",
          "* [Landsat 8](https://landsat.gsfc.nasa.gov/landsat-8/)",
          "* [VIIRS](https://ncc.nesdis.noaa.gov/VIIRS/)",
          "* [MODIS](https://terra.nasa.gov/about/terra-instruments/modis)\n",
          "More information on the satellites and processing levels that are supported can be found [here](https://github.com/deephdc/satsr/blob/master/reports/additional_notes.md)",
          "along with some [demo images](https://github.com/deephdc/satsr/tree/master/reports/figures) of the super-resolutions performed in non-training data.\n",
          "If you want to perform super-resolution on another satellite, go to the [training section](https://github.com/deephdc/satsr#train-other-satellites)",
          "to see how you can easily add support for additional satellites. We are happy to accept PRs!\n",
          "<img class='fit', src='https://raw.githubusercontent.com/deephdc/DEEP-OC-satsr/master/images/satsr.png'/>\n",
          "**References**\n",
          "[1]: Lanaras, C., Bioucas-Dias, J., Galliani, S., Baltsavias, E., & Schindler, K. (2018). [Super-resolution of Sentinel-2 images: Learning a globally applicable deep neural network](https://arxiv.org/abs/1803.04271). ISPRS Journal of Photogrammetry and Remote Sensing, 146, 305-319."],
        "keywords":["models",
          "services",
          "library/tensorflow",
          "library/keras",
          "docker"],
        "license":"Apache 2.0",
        "date_creation":"2019-01-01T00:00:00Z",
        "id":"https://github.com/deephdc/DEEP-OC-satsr",
        "sources_dockerfile_repo":"https://github.com/deephdc/DEEP-OC-satsr",
        "_version_":1646289476687757312},
      {
        "title":"DEEP OC Seeds Classification (Theano)",
        "summary":"A trained ResNet50 on Theano to classify seeds.",
        "description":["**This service is deprecated. Please refer to the [newer Tensorflow version](deep-oc-seeds-classification.html)**.\n",
          "Citizen science has become a powerful force for scientific inquiry, providing researchers with access to a vast array of",
          "data points while connecting non scientists to the real process of science. This citizen-researcher relationship",
          "creates a very interesting synergy, allowing for the creation, execution, and analysis of research projects. ",
          "With this in mind, a Convolutional Neural Network has been trained to identify seed images in collaboration ",
          "with [Spanish Royal Botanical Garden](http://www.rjb.csic.es).\n",
          "This Docker container contains a trained Convolutional Neural network optimized for seeds identification using",
          "images. The architecture used is an ResNet50 [1] network using Lasagne on top of Theano.\n",
          "As training dataset we have used a collection of images from the [Spanish Royal Botanical Garden](http://www.rjb.csic.es)",
          "which consists of around 28K images from 743 species and 493 genera.\n",
          "<img class='fit', src='https://raw.githubusercontent.com/deephdc/DEEP-OC-seeds-classification/master/images/seeds.png'/>\n",
          "**References**\n",
          "[1]: He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep residual learning for image recognition. In Proceedings of the IEEE conference on computer vision and pattern recognition (pp. 770-778)\n"],
        "keywords":["deprecated/services",
          "library/theano",
          "library/lasagne",
          "docker"],
        "license":"Apache 2.0",
        "date_creation":"2019-01-01T00:00:00Z",
        "id":"https://github.com/deephdc/DEEP-OC-seeds-classification",
        "sources_dockerfile_repo":"https://github.com/deephdc/DEEP-OC-seeds-classification",
        "_version_":1646289477321097216}]
  }}
```

## Directory structure
* [./exampledocs](https://github.com/deephdc/oc-search-engine/tree/master/exampledocs) - Sample metadata.json files taken from DEEP use-cases
* [./home](https://github.com/deephdc/oc-search-engine/tree/master/home) - Solr home directory
* [./scripts](https://github.com/deephdc/oc-search-engine/tree/master/scripts) - various usable scripts
