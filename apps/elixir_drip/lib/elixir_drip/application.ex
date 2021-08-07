defmodule ElixirDrip.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirDrip.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirDrip.PubSub}
      # Start a worker by calling: ElixirDrip.Worker.start_link(arg)
      # {ElixirDrip.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ElixirDrip.Supervisor)
  end
end
