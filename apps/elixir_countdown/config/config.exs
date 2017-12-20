use Mix.Config

config :elixir_countdown, 
  ecto_repos: [
    ElixirCountdown.Repo
  ]

config :elixir_countdown, ElixirCountdown.Repo,
  adapter: Ecto.Adapters.Postgres

config :logger, level: :info

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
