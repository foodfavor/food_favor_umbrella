import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :food_favor, FoodFavor.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "food_favor_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_favor_web, FoodFavorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "APDBlw7uYLYIT4uafJAyJgBSB7v0WsOrOiM/x/Y7TTFzKHfXl8jfB0IkVjlEILL4",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :food_favor, FoodFavor.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
