#!/bin/bash

mkdir -p ./tor/cfg ./tor/data
sudo echo 'SOCKSPort 0.0.0.0:9050'$'\n''DataDirectory /var/lib/tor' > ./tor/cfg/torrc
sudo chown 100:100 ./tor/data
sudo docker-compose up -d