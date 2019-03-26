defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller
  alias EmojiWeb.EmojiService

  def show(conn, %{"emoji_name" => emoji_name}) do
    case EmojiService.get_emoji(emoji_name) do
      nil -> conn |> put_status(404) |> json(%{message: "No emojis found! Srrrry"})
      emoji -> json(conn, %{unicode: emoji})
    end
  end
end
