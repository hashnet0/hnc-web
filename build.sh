#!/bin/bash

# Set the directory to this script's current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

source ./settings.sh

docker rmi ${IMAGE_NAME}
docker build \
	--force-rm \
	--rm \
	--build-arg NGINX_WORKER_CONNECTIONS=${NGINX_WORKER_CONNECTIONS} \
	--build-arg NGINX_MULTI_ACCEPT=${NGINX_MULTI_ACCEPT} \
	--build-arg NGINX_WORKER_PRIORITY=${NGINX_WORKER_PRIORITY} \
	--tag ${IMAGE_NAME} .

