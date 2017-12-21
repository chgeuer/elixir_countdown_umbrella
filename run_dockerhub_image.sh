#!/bin/bash

source ./variables.sh

docker run -it --rm -p 4000:4000 --env-file secret.env "chgeuer/elixir_countdown_umbrella:latest"
