defmodule EmojiWeb.EmojiControllerTest do
  use EmojiWeb.ConnCase

  describe "GET /emojis/:emoji_name" do
    test "It will return a matching emoji unicode for sparkles", %{conn: conn} do
      conn = get(conn, "/emojis/sparkles")
      response = json_response(conn, 200)
      assert response["unicode"] == "✨"
    end

    test "It will return a matching emoji unicode for tada", %{conn: conn} do
      conn = get(conn, "/emojis/tada")
      response = json_response(conn, 200)
      assert response["unicode"] == "🎉"
    end

    test "It will return 404 if no emojis match", %{conn: conn} do
      conn = get(conn, "/emojis/noemoji")
      assert json_response(conn, 404)
    end
  end

  describe "GET /emojis?name=emoji_name" do
    test "It will return all matching emoji unicodes for moon", %{conn: conn} do
      conn = get(conn, "/emojis?name=moon")
      response = json_response(conn, 200)
      assert length(response) === 13
      assert Enum.member?(response, %{"unicode" => "🌔"})
    end

    test "It will return all emoji unicodes if no query is passed", %{conn: conn} do
      conn = get(conn, "/emojis")
      response = json_response(conn, 200)
      assert length(response) === 845
      assert Enum.member?(response, %{"unicode" => "💃"})
    end

    test "It will return an empty list if no emojis match", %{conn: conn} do
      conn = get(conn, "/emojis?name=somenonsense")
      response = json_response(conn, 200)
      assert response == []
    end
  end

  describe "GET /emojis/reverse/:emoji" do
    test "It will the emoji information for 🙋", %{conn: conn} do
      conn = get(conn, "/emojis/reverse/🙋")
      response = json_response(conn, 200)
      assert response["short_names"] == ["raising_hand"]
    end

    test "It will return 404 if no emojis match", %{conn: conn} do
      conn = get(conn, "/emojis/reverse/noemoji")
      assert json_response(conn, 404)
    end
  end
end
