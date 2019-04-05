defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller
  alias EmojiWeb.EmojiService

  def index(conn, %{"name" => emoji_name}) do
    case EmojiService.get_emoji(emoji_name) do
      [] -> json(conn, [])
      emojis -> json(conn, emojis |> Enum.map(&EmojiService.render_unicode/1))
    end
  end

  def index(conn, %{}) do
    emojis = EmojiService.get_all()
    json(conn, emojis |> Enum.map(&EmojiService.render_unicode/1))
  end

  def show(conn, %{"emoji_name" => emoji_name}) do
    case EmojiService.get_emoji(emoji_name) do
      [] -> conn |> put_status(404) |> json(%{message: "No emojis found! Srrrry"})
      [emoji | _] -> json(conn, EmojiService.render_unicode(emoji))
    end
  end

  def reverse_search(conn, %{"emoji" => emoji}) do
    case EmojiService.name_from_emoji(emoji) do
      nil -> conn |> put_status(404) |> json(%{message: "No emojis found! Srrrry"})
      emoji -> json(conn, emoji |> Map.from_struct)
    end
  end

end
