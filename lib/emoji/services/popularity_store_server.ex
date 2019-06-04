defmodule Emoji.PopularityStoreServer do
  @moduledoc """
  Our emoji popularity store, implemented as a GenServer. A GenServer is a
  generic approach for implementing a stateful process. In this store module, we
  bundle both the client API for interacting with our GenServer and the internal
  process callbacks used to respond to inbound messages.
  """

  use GenServer

  # %%% Client API %%%
  #
  # Here we expose a series of functions for interacting with our GenServer
  # process. These functions generally wrap calls to functions on the `GenServer`
  # module, and will ultimately invoke callbacks on the GenServer process that
  # we handle below.
  #
  # Docs for valid GenServer functions: https://hexdocs.pm/elixir/GenServer.html#functions

  @doc """
  Starts our popularity store as a global GenServer, initialized with an empty
  map. The `name: __MODULE__` option makes our GenServer process globally accessible,
  via the `__MODULE__` alias helper.
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc """
  Retrieves an emoji by the given name. Returns nil if no emoji is found.
  """
  def get(emoji_name) do
    GenServer.call(__MODULE__, :get)
    |> Map.get(emoji_name)
  end

  @doc """
  Returns a list of the most popular emoji stored.
  """
  def get_most_popular(to_take \\ 5) do
    GenServer.call(__MODULE__, :get)
    |> Enum.sort(&(elem(&1, 1) > elem(&2, 1)))
    |> Enum.take(to_take)
    |> Enum.map(fn {k, _v} -> k end)
  end

  @doc """
  Increments the popularity count of the emoji given by 1. If the emoji isn't
  already in state, an initial popularity count is set to 1.
  """
  def inc_popularity(emoji_name) do
    GenServer.cast(__MODULE__, {:increase_pop, emoji_name})
  end

  @doc """
  Removes an emoji from the popularity list
  """
  def remove_emoji(emoji_name) do
    GenServer.cast(__MODULE__, {:remove, emoji_name})
  end

  @doc """
  Clears all emojis from the popularity list
  """
  def clear_state() do
    GenServer.cast(__MODULE__, {:clear})
  end

  # %%% Internal Callbacks %%%
  #
  # Functions used to handle interaction with our GenServer process. You can find
  # the full list of valid callbacks plus valid responses for each here:
  # https://hexdocs.pm/elixir/GenServer.html#callbacks

  # Callback invoked by `GenServer.start_link/3`. We reply with the initial state.
  def init(state), do: {:ok, state}

  def handle_call(:get, _from, state), do: {:reply, state, state}

  def handle_cast({:increase_pop, emoji_name}, state) do
    new_state = case Map.get(state, emoji_name) do
      nil -> Map.put(state, emoji_name, 1)
      popularity -> Map.put(state, emoji_name, popularity + 1)
    end
    {:noreply, new_state}
  end
  def handle_cast({:remove, emoji_name}, state), do: {:noreply, Map.delete(state, emoji_name)}
  def handle_cast({:clear}, _state), do: {:noreply, %{}}
end
