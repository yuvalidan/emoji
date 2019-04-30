defmodule EmojiWeb.Router do
  use EmojiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EmojiWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/emojis", EmojiController, :index

    get "/emojis/popular", EmojiController, :popular

    get "/emojis/reverse/:emoji", EmojiController, :reverse_search

    get "/emojis/:emoji_name", EmojiController, :show

  end
end
