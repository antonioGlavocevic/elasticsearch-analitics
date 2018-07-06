#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo chown root:root $DIR/packetbeat/packetbeat.yml
sudo chown 1000:root $DIR/logstash/log
sudo chown -R 1000:root $DIR/elasticsearch/data
