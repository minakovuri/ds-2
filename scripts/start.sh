#!/usr/bin/env bash

# To parse JSON params, you should run `sudo apt install jq`
JQ_OK=$(dpkg-query -W --showformat='${Status}\n' jq | grep "install ok installed")
if [ "" == "$JQ_OK" ]; then
    echo " --------- INSTALLING JSON PARSER ---------- "
    sudo apt install jq
fi

BACKEND_API_HOST=$( jq .BackendApi.host ../config/config.json | tr -d '"' )
BACKEND_API_PORT=$( jq .BackendApi.port ../config/config.json )
FRONTEND_PORT=$( jq .Frontend.port ../config/config.json )

echo " --------- START CONTAINERS ---------- "

# Run BackendApi
docker run -e ASPNETCORE_URLS=http://+:${BACKEND_API_PORT} --rm -d -p ${BACKEND_API_PORT}:${BACKEND_API_PORT} --name backend-api ds-2/backend-api

# Run Frontend
docker run -e ASPNETCORE_URLS=http://+:${FRONTEND_PORT} -e BACKEND_API_HOST=$BACKEND_API_HOST -e BACKEND_API_PORT=${BACKEND_API_PORT} --rm -d -p ${FRONTEND_PORT}:${FRONTEND_PORT} --name frontend --link=backend-api ds-2/frontend