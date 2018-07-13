## Prerequisites

* Docker
* Linux

###### Linux is required as otherwise the packetbeat container will not pick up traffic outside the Docker LinuxVM.

## Setup

If you want to preload data into your elasticsearch, copy the data/nodes directory from the elasticsearch of your choice to **./elasticsearch/data/nodes**.

Run `./prepare.sh` to set the ownerships of the required files (including the ./elasticsearch/data/nodes that you copied over) so that docker can write to them.

Run `./start.sh` to start the 3 docker containers (packetbeat, logstash, elasticsearch). 

Logstash takes the longest to spin up. To see if it is ready, run the command `docker logs -f logstash` and wait for the line **[INFO ][logstash.agent           ] Pipelines running** (exit with Ctrl+C).

Elasticsearch is listening on **PORT: 9200**

## Running

Packbeat will catch any http traffic hitting 9200 and logstash will push any packets that are directed to the path */_search (e.g. http://localhost:9200/courses/course/_search). Elasticsearch will make a new index for logstash named logstash-\<date\> (date is in yyyy.MM.dd format). This index can then be queried the same way as any other elasticsearch index.

You can view all indicies using 
```
curl -X GET "http://13.211.131.125:9200/_cat/indices?v" -H 'Content-Type: application/json'
```

Then query an index (*logstash-2018.07.13* is the index below)
```
curl -X GET "http://localhost:9200/logstash-2018.07.13/doc/_search" -H 'Content-Type: application/json' -d'
{
    "query": {
        "match_all": {}
    }
}
'
```

## Stop and cleanup

Run `./stop.sh` to stop and remove the containers.

If you would like to purge the elasticsearch data run `sudo rm -rf ./elasticsearch/data/nodes` after the elasticsearch container has been removed.
