#!/bin/bash

# Start Elasticsearch container
docker run -d --name elasticsearch \
    -p 9200:9200 -p 9300:9300 \
    -e "discovery.type=single-node" \
    docker.elastic.co/elasticsearch/elasticsearch:7.16.3

# Start Logstash container
docker run -d --name logstash \
    --link elasticsearch:elasticsearch \
    -v /path/to/logstash/config:/usr/share/logstash/config \
    docker.elastic.co/logstash/logstash:7.16.3

# Start Kibana container
docker run -d --name kibana \
    --link elasticsearch:elasticsearch \
    -p 5601:5601 \
    docker.elastic.co/kibana/kibana:7.16.3
