#!/usr/bin/env bash

# Build container for BackendApi
docker build --rm --target backend-api -t ds-2/backend-api:latest .

# Build container for Frontend
docker build --rm --target frontend -t ds-2/frontend:latest .