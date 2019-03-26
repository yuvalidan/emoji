defmodule EmojiWeb.EmojiControllerTest do
  use EmojiWeb.ConnCase

  describe "GET /emojis/:emoji_name" do
    test "It will return a matching emoji unicode", %{conn: conn} do
      conn = get(conn, "/emojis/sparkles")
      response = json_response(conn, 200)
      assert response["unicode"] == "✨"
    end

    test "It will return 404 if no emojis match", %{conn: conn} do
      conn = get(conn, "/emojis/noemoji")
      assert json_response(conn, 404)
    end
  end
end
