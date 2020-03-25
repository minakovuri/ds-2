#!/usr/bin/env bash

# Run BackendApi
docker run --rm -d -p 5000:5000 --name backend-api ds-2/backend-api

# Run Frontend
docker run --rm -d -p 5001:5001 --name frontend --link=backend-api ds-2/frontend