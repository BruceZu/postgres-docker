#!/bin/bash
POSTGRES_NAME=${POSTGRES_NAME:-$1}
POSTGRES_VOLUME=${POSTGRES_VOLUME:-$1-volume}

docker stop ${POSTGRES_NAME}
docker rm -v ${POSTGRES_NAME}
docker rm -v ${POSTGRES_VOLUME}
