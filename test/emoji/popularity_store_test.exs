defmodule Emoji.PopularityStoreTest do
  use ExUnit.Case, async: true
  alias Emoji.PopularityStore

  describe "get_most_popular" do
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
      inc_pop_by("moon", 5)
      inc_pop_by("vampire", 2)
      inc_pop_by("sparkles", 6)
      inc_pop_by("vulcan", 3)
      inc_pop_by("checkmark", 1)
      inc_pop_by("sparkles", 1)
      inc_pop_by("tada", 4)
      inc_pop_by("sparkles", 1)
      assert PopularityStore.get_most_popular(2) === ["sparkles", "moon"]
    end
  end

  defp inc_pop_by(emoji, times) do
    Enum.each(0..times, fn _ -> PopularityStore.inc_popularity(emoji) end)
  end
end
