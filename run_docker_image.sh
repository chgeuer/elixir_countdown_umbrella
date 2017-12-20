#!/bin/bash

source ./variables.sh

docker run -it --rm -p 4000:4000 --env-file secret.env "${acr_url}/${IMAGE_NAME}:${IMAGE_VERSION}"
