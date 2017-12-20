defmodule ElixirCountdown.Application do
  @moduledoc """
  The ElixirCountdown Application Service.

  The elixir_countdown system business domain lives in this application.

  Exposes API to clients such as the `ElixirCountdownWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    ElixirCountdown.Configuration.initialize_config()

    Supervisor.start_link([
      supervisor(ElixirCountdown.Repo, []),
    ], strategy: :one_for_one, name: ElixirCountdown.Supervisor)
  end
end
