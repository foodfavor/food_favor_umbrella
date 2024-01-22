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

# Configure Mix tasks and generators
config :food_favor,
  ecto_repos: [FoodFavor.Repo]

config :food_favor, FoodFavor.Repo, migration_timestamps: [type: :utc_datetime]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :food_favor, FoodFavor.Mailer, adapter: Swoosh.Adapters.Local

config :food_favor_web,
  ecto_repos: [FoodFavor.Repo],
  generators: [context_app: :food_favor, binary_id: true]

# Configures the endpoint
config :food_favor_web, FoodFavorWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: FoodFavorWeb.ErrorHTML, json: FoodFavorWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FoodFavor.PubSub,
  live_view: [signing_salt: "qx67PaWb"]

# Configures Sentry logging
config :sentry,
  dsn:
    "https://1b8711b48709671ec8e1258e12c46030@o4506615880613888.ingest.sentry.io/4506615881138176",
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_paths: [File.cwd!()]

config :logger, Sentry.LoggerBackend,
  # Also send warning messages
  level: :warning,
  # Send messages from Plug/Cowboy
  excluded_domains: [],
  # Include metadata added with `Logger.metadata([foo_bar: "value"])`
  metadata: [:errors],
  # Send messages like `Logger.error("error")` to Sentry
  capture_log_messages: true

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/food_favor_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/food_favor_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
