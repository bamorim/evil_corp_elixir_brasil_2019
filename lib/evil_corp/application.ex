defmodule EvilCorp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children =
      [
        db: EvilCorp.Repo,
        web: EvilCorpWeb.Endpoint,
        worker: {Oban, Application.get_env(:evil_corp, Oban)}
      ]
      |> Enum.filter(fn {key, _} -> key in components_to_start() end)
      |> Enum.map(fn {_, spec} -> spec end)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EvilCorp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EvilCorpWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp components_to_start,
    do: Application.get_env(:evil_corp, :components_to_start, [:db, :web, :worker])
end
