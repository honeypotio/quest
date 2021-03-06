# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :quest_admin,
  ecto_repos: [QuestAdmin.Repo]

# Configures the endpoint
config :quest_admin, QuestAdmin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "23kUQJKxBG1edxOfeDQR4j89M+a7bo8XUoQ0R8ZIUeOYHNqljT34M4W0S6d37gMD",
  render_errors: [view: QuestAdmin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: QuestAdmin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
