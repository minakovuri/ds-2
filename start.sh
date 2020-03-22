#!/usr/bin/env bash

# Run BackendApi
docker run -it -d -p 5000:5000 --name backend-api ds-2/backend-api

# Run Frontend
docker run --rm -d -p 5002:80 --link backend-api --name frontend ds-2/frontend