# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quest_api,
  ecto_repos: [QuestApi.Repo]

# Configures the endpoint
config :quest_api, QuestApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ncDG3S7oXer4xlGxfexTFheXS9C5Z6R3es+ziP42DmPbHyAeSc0JOPQcmTzYL5yr",
  render_errors: [view: QuestApi.ErrorView, accepts: ~w(json)],
  pubsub: [name: QuestApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
