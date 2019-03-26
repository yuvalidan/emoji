# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :emoji,
  ecto_repos: [Emoji.Repo]

# Configures the endpoint
config :emoji, EmojiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9BAZfclM/jUWrD8+9oWQaPl1aW2LOqTeUxlld7jiecEO/DEm93i2xuAUg/Zao52+",
  render_errors: [view: EmojiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Emoji.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
