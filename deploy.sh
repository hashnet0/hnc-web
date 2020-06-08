#!/bin/bash

# Set the directory to this script's current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

source ./settings.sh

docker run -d -i -t \
	-e CONTAINER_NAME=${CONTAINER_NAME} \
	--memory=${MEMORY_MAX} \
	--memory-swap=${MEMORY_MAX} \
	--memory-swappiness=0 \
	--restart always \
	--name ${CONTAINER_NAME} \
	--mount "type=volume,src=${VOLUME_NAME},dst=/etc/nginx,volume-driver=local" \
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-p 80:80 \
	-p 443:443 \
	${IMAGE_NAME}

