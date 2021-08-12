defmodule ElixirDrip.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias ElixirDrip.Storage.Supervisors.CacheSupervisor

  def start(_type, _args) do
    children = [
      ElixirDrip.Repo,
      {Phoenix.PubSub, name: ElixirDrip.PubSub},
      CacheSupervisor,
      {Registry, [keys: :unique, name: ElixirDrip.Registry]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ElixirDrip.Supervisor)
  end
end
