#!/bin/bash

sudo chown root:root $PWD/packetbeat/packetbeat.yml
sudo chown 1000:root $PWD/logstash/log
sudo chown -R 1000:root $PWD/elasticsearch/data
