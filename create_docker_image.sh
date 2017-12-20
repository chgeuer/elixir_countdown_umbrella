#!/bin/bash

source ./variables.sh

docker build --tag "${acr_url}/${IMAGE_NAME}:${IMAGE_VERSION}" .
