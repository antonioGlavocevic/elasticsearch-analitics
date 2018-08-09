#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo chown 1000 $DIR/packetbeat/packetbeat.yml
sudo chmod go-w $DIR/packetbeat/packetbeat.yml
sudo chown 1000 $DIR/logstash/log
sudo chown -R 1000 $DIR/elasticsearch/data
