defmodule Emoji.PopularityStoreServerTest do
  use ExUnit.Case, async: true
  alias Emoji.PopularityStoreServer

  setup do
    PopularityStoreServer.clear_state()
  end

  describe "get_most_popular" do
    test "returns empty list if nothing is in the store" do
      assert PopularityStoreServer.get_most_popular() === []
    end

    test "returns values by key" do
      inc_pop_by("moon", 5)
      inc_pop_by("vampire", 2)
      inc_pop_by("sparkles", 6)
      inc_pop_by("vulcan", 3)
      inc_pop_by("checkmark", 1)
      inc_pop_by("sparkles", 1)
      inc_pop_by("tada", 4)
      inc_pop_by("sparkles", 1)
      assert PopularityStoreServer.get_most_popular() === ["sparkles", "moon", "tada", "vulcan", "vampire"]
    end

    test "returns passed number of values" do
      inc_pop_by("moon", 10)
      inc_pop_by("vampire", 2)
      inc_pop_by("sparkles", 5)
      inc_pop_by("vulcan", 3)
      inc_pop_by("checkmark", 1)
      inc_pop_by("sparkles", 1)
      inc_pop_by("tada", 4)
      inc_pop_by("sparkles", 1)
      assert PopularityStoreServer.get_most_popular(2) === ["moon", "sparkles"]
    end
  end

  describe "remove_emoji" do
    test "removes an emoji from popularity store" do
      inc_pop_by("moon", 5)
      inc_pop_by("vampire", 2)
      inc_pop_by("sparkles", 6)
      inc_pop_by("vulcan", 3)
      inc_pop_by("sparkles", 1)
      inc_pop_by("tada", 4)
      inc_pop_by("sparkles", 1)
      PopularityStoreServer.remove_emoji("moon")
      assert PopularityStoreServer.get_most_popular() === ["sparkles", "tada", "vulcan", "vampire"]
    end

    test "does nothing if the emoji is not in the store" do
      inc_pop_by("vampire", 2)
      inc_pop_by("sparkles", 6)
      inc_pop_by("vulcan", 3)
      inc_pop_by("sparkles", 1)
      inc_pop_by("tada", 4)
      inc_pop_by("sparkles", 1)
      PopularityStoreServer.remove_emoji("moon")
      assert PopularityStoreServer.get_most_popular() === ["sparkles", "tada", "vulcan", "vampire"]
    end
  end

  defp inc_pop_by(emoji, times) do
    Enum.each(0..times, fn _ -> PopularityStoreServer.inc_popularity(emoji) end)
  end
end
