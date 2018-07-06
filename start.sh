#!/bin/bash

docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 \
  -v $PWD/elasticsearch/data:/usr/share/elasticsearch/data \
  -v $PWD/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4

docker run -d --name logstash -p 9600:9600 -p 5044:5044 \
  -v $PWD/logstash/pipeline:/usr/share/logstash/pipeline \
  -v $PWD/logstash/log:/usr/share/logstash/log \
  docker.elastic.co/logstash/logstash-oss:6.2.4

docker run -d --name packetbeat --network host --cap-add=NET_ADMIN \
  -v $PWD/packetbeat/packetbeat.yml:/usr/share/packetbeat/packetbeat.yml \
  docker.elastic.co/beats/packetbeat:6.2.4
