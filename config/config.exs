# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :covid19_data,
  generators: [timestamp_type: :utc_datetime]

config :covid19_data, Covid19DataWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: Covid19DataWeb.ErrorHTML, json: Covid19DataWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Covid19Data.PubSub,
  live_view: [signing_salt: "dFvRmKNp"]

config :covid19_data, Covid19Data.Mailer, adapter: Swoosh.Adapters.Local

config :esbuild,
  version: "0.17.11",
  covid19_data: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.4.0",
  covid19_data: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
