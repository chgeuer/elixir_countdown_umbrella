use Mix.Config

config :elixir_countdown, ecto_repos: [ElixirCountdown.Repo]

import_config "#{Mix.env}.exs"
