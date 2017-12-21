mix phx.new --umbrella elixir_countdown
cd elixir_countdown_umbrella

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs



mix deps.get
cd assets && npm install && node node_modules/brunch/bin/brunch build
mix deps.compile


npm ERR! code UNABLE_TO_GET_ISSUER_CERT_LOCALLY
npm ERR! errno UNABLE_TO_GET_ISSUER_CERT_LOCALLY
npm ERR! request to https://registry.npmjs.org/babel-brunch failed, reason: unable to get local issuer certificate
