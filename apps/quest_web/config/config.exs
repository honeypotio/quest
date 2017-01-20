# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :quest_web, QuestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ISQx4ygatbKcbt2pQVeIY1Ncqikr8JTVeH42f0IZR/8R552+6/2vRE7TMw5kJOfL",
  render_errors: [view: QuestWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuestWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
