#!/bin/bash

# Docker image name
IMAGE_NAME="hnc-web:latest"

# The container's name when using ./run.sh
CONTAINER_NAME="hnc-web"

# The maximum memory allowed in this container
MEMORY_MAX="1024m"

# The mounted volume name when using ./run.sh
VOLUME_NAME=${CONTAINER_NAME}

# Enable or disable `multi_accept` mode for workers (on or off)
NGINX_MULTI_ACCEPT="on"

# Max number of nginx worker connections
NGINX_WORKER_CONNECTIONS="2048"

# Niceness (-20 to 20)
NGINX_WORKER_PRIORITY="-10"

