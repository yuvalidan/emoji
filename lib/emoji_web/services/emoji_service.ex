defmodule EmojiWeb.EmojiService do


  def get_emoji(emoji_name) do
    emoji_name = String.downcase(emoji_name)
    emojis = %{sparkles: "✨", vulcan: "🖖", "white check mark": "✅", "nail care": "💅"}
    Map.get(emojis, String.to_atom(emoji_name))
    # case Ecto.UUID.cast(user_id) do
    #   {:ok, _} -> with user <- Users.get_user(user_id) do
    #     IO.inspect(user)
    #     handle_notify(EmailOpened, %{user: user, email_type: email_type})
    #   end
    #   :error -> nil
    # end
  end

end
