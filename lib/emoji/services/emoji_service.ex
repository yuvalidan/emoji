defmodule EmojiWeb.EmojiService do
  def get_emoji(emoji_name) do
    emoji_name
    |> String.downcase()
    |> Exmoji.find_by_short_name()
  end

  def render_unicode(emoji) do
    %{unicode: Exmoji.EmojiChar.render(emoji)}
  end

  def get_all() do
    Exmoji.all()
  end

  def name_from_emoji(emoji) do
    Exmoji.char_to_unified(emoji)
    |> Exmoji.from_unified()
  end
end
