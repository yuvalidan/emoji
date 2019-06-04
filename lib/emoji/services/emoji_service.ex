defmodule Emoji.EmojiService do
  alias Emoji.PopularityStoreServer

  def find_emoji(emoji_name) do
    emoji_name
    |> String.downcase()
    |> Exmoji.find_by_short_name()
  end

  def get_emoji(emoji_name) do
    emoji_name
    |> String.downcase()
    |> Exmoji.from_short_name()
    |> add_to_store()
  end

  def render_unicode(emoji) do
    %{unicode: Exmoji.EmojiChar.render(emoji)}
  end

  def get_rendered_emoji(emoji_name) do
    case get_emoji(emoji_name) do
      nil -> nil
      emoji -> render_unicode(emoji)
    end
  end

  def get_all(), do: Exmoji.all()

  def get_popular(), do: PopularityStoreServer.get_most_popular()

  def name_from_emoji(emoji) do
    Exmoji.char_to_unified(emoji)
    |> Exmoji.from_unified()
  end

  defp add_to_store(nil), do: nil
  defp add_to_store(%{short_name: short_name} = emoji) do
    PopularityStoreServer.inc_popularity(short_name)
    emoji
  end
end
