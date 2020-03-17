#!/usr/bin/env bash

# Run Frontend
# docker run --rm -d -p 5002:80 --name frontend ds-2/frontend

# Run BackendApi
docker run -it -d -p 5000:5000 --name backend-api ds-2/backend-api