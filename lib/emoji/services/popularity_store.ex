defmodule Emoji.PopularityStore do
  use Agent

  @doc """
  Starts our popularity store as a global agent, initialized with an empty map.
  We use __MODULE__ as the name of the agent so that we can reference it globally.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc """
  Retrieves an emoji by the name given. Returns nil if no emoji is found.
  """
  def get(emoji_name) do
    Agent.get(__MODULE__, &Map.get(&1, emoji_name))
  end

  @doc """
  Increments the popularity count of the emoji given by 1
  """
  def inc_popularity(emoji_name) do
    Agent.update(__MODULE__, fn state ->
      case Map.get(state, emoji_name) do
        nil -> Map.put(state, emoji_name, 1)
        popularity -> Map.put(state, emoji_name, popularity + 1)
      end
    end)
  end

  @doc """
  Returns a list of the most popular emoji stored.
  """
  def get_most_popular(to_take \\ 5) do
    Agent.get(__MODULE__, fn state -> state end)
    |> Enum.sort(&(elem(&1, 1) > elem(&2, 1)))
    |> Enum.take(to_take)
    |> Enum.map(fn {k, _v} -> k end)
  end

  def clear_state() do
    Agent.update(__MODULE__, fn _state -> %{} end)
  end
end
