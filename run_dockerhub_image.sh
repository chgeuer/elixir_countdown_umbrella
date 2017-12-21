#!/bin/bash

source ./variables.sh

cp -u -p secret_template.env secret.env

docker run -it --rm -p 4000:4000 --env-file secret.env "chgeuer/elixir_countdown_umbrella:latest"
