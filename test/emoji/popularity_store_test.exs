defmodule Emoji.PopularityStoreTest do
  use ExUnit.Case, async: true
  alias Emoji.PopularityStore

  setup do
    PopularityStore.clear_state()
  end

  describe "get_most_popular" do
    test "returns empty list if nothing is in the store" do
      assert PopularityStore.get_most_popular() === []
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
      assert PopularityStore.get_most_popular() === ["sparkles", "moon", "tada", "vulcan", "vampire"]
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
      assert PopularityStore.get_most_popular(2) === ["moon", "sparkles"]
    end
  end

  defp inc_pop_by(emoji, times) do
    Enum.each(0..times, fn _ -> PopularityStore.inc_popularity(emoji) end)
  end
end
