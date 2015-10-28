#!/bin/bash
set -e
POSTGRES_NAME=${POSTGRES_NAME:-$1}
POSTGRES_VOLUME=${POSTGRES_VOLUME:-$1-volume}
POSTGRES_IMAGE=${POSTGRES_IMAGE:-postgres:9.4}
POSTGRES_DB=${POSTGRES_DB:-$2}
POSTGRES_USER=${POSTGRES_USER:-$3}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-$4}

# Create PostgreSQL volume.
docker run \
--name ${POSTGRES_VOLUME} \
${POSTGRES_IMAGE} \
echo "Create postgres volume."

# Start PostgreSQL.
docker run \
--name ${POSTGRES_NAME} \
-P \
--volumes-from ${POSTGRES_VOLUME} \
-e POSTGRES_DB=${POSTGRES_DB} \
-e POSTGRES_USER=${POSTGRES_USER} \
-e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
-d ${POSTGRES_IMAGE}

while [ -z "$(docker logs ${POSTGRES_NAME} 2>&1 | grep 'autovacuum launcher started')" ]; do
    echo "Waiting postgres ready."
    sleep 1
done
