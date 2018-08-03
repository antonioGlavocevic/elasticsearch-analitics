#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run -d --name elasticsearch -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 \
  -v $DIR/elasticsearch/data:/usr/share/elasticsearch/data \
  -v $DIR/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4

docker run -d --name logstash -p 127.0.0.1:9600:9600 -p 127.0.0.1:5044:5044 \
  -v $DIR/logstash/pipeline:/usr/share/logstash/pipeline \
  -v $DIR/logstash/config/logstash.yml:/usr/share/logstash/config/logstash.yml \
  -v $DIR/logstash/log:/usr/share/logstash/log \
  docker.elastic.co/logstash/logstash-oss:6.2.4

docker run -d --name packetbeat --network host --cap-add=NET_ADMIN \
  -v $DIR/packetbeat/packetbeat.yml:/usr/share/packetbeat/packetbeat.yml \
  docker.elastic.co/beats/packetbeat:6.2.4
