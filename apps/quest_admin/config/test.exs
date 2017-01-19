use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quest_admin, QuestAdmin.Endpoint,
  http: [port: 4003],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :quest_admin, QuestAdmin.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "quest_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
