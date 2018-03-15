#!/bin/bash -ex

tag=gamblecoin-dnsseeder
name=dnsseed

docker build -t $tag .

set +e
docker rm -f $name
set -e

docker run -d \
    -p 53:53/udp \
    --restart=always \
    --name $name $tag \
    -h dnsseed.test.tld \
    -n node.test.tld \
    -m support.test.tld \
    -t 96 -d 2 \
    --testnet
