use Mix.Config

# Configure your database
config :elixir_countdown, ElixirCountdown.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixir_countdown_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
