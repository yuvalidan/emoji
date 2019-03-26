defmodule EmojiWeb.EmojiService do
  def get_emoji(emoji_name) do
    emoji_name
    |> String.downcase()
    |> find_emoji_in_map()
  end

  defp find_emoji_in_map(emoji_name) do
    emojis = %{sparkles: "✨", vulcan: "🖖", "white check mark": "✅", "nail care": "💅"}
    Map.get(emojis, String.to_atom(emoji_name))
  end
end
