use Mix.Config

# Configure your database
config :evil_corp, EvilCorp.Repo,
  username: "postgres",
  password: "postgres",
  database: "evil_corp_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :evil_corp, EvilCorpWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :evil_corp, EvilCorp.Mailer, adapter: Bamboo.TestAdapter
