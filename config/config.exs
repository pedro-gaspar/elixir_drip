# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :elixir_drip_web,
  ecto_repos: [ElixirDripWeb.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :elixir_drip_web, ElixirDripWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0lUU5K8/Aa9Ue6sLLPcBMIAmyuudYtJomz2LAnlz6eZmkGl+bsi/ZbUuem2hFt+h",
  render_errors: [view: ElixirDripWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirDripWeb.PubSub,
  live_view: [signing_salt: "lDJ32ivM"]

# Configure Mix tasks and generators
config :elixir_drip,
  ecto_repos: [ElixirDrip.Repo]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_drip, storage_provider: ElixirDrip.Storage.Providers.GoogleCloudStorageLocal

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
