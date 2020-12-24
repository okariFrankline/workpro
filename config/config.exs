# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eworks,
  ecto_repos: [Eworks.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :eworks, EworksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Oo471JYlimx2HkY7nmS+xPGf1AuscPnFZLvCUjacekozP6/T8wpGSyjTzNj7yDty",
  render_errors: [view: EworksWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Eworks.PubSub,
  live_view: [signing_salt: "s2gFp5wf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
