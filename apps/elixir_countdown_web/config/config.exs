# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_countdown_web,
  namespace: ElixirCountdownWeb,
  ecto_repos: [ElixirCountdown.Repo]

# Configures the endpoint
config :elixir_countdown_web, ElixirCountdownWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SoFfxg04AVRO1RH0fZifmiuxrCbb5zITJQq6hvp/tG7/pN/VrwtEvqBxcIbQug7U",
  render_errors: [view: ElixirCountdownWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirCountdownWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  server: true,
  root: ".",
  version: Application.spec(:phoenix_distillery, :vsn)

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir_countdown_web, :generators,
  context_app: :elixir_countdown

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
