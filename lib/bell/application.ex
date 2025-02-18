defmodule Bell.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BellWeb.Telemetry,
      Bell.Repo,
      {DNSCluster, query: Application.get_env(:bell, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Bell.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Bell.Finch},
      # Start a worker by calling: Bell.Worker.start_link(arg)
      # {Bell.Worker, arg},
      # Start to serve requests, typically the last entry
      BellWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bell.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BellWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
