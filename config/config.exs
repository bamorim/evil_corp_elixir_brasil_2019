# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :evil_corp,
  ecto_repos: [EvilCorp.Repo]

# Configures the endpoint
config :evil_corp, EvilCorpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9E1wWhDM2PadMMWuOLd6z4T7UDfV2LFwbYeHjysBds+ONUYxWnPtKTQn2Yx2SC2O",
  render_errors: [view: EvilCorpWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: EvilCorp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :evil_corp, Oban,
  repo: EvilCorp.Repo,
  queues: [default: 10]
