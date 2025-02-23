defmodule Cache do
  use GenServer

  @name __MODULE__

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, value) do
    GenServer.cast(@name, {:write, key, value})
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def exist?(key) do
    GenServer.call(@name, {:exist, key})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def clear() do
    GenServer.cast(@name, :clear)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:write, key, value}, cache) do
    {:noreply, Map.put(cache, key, value)}
  end

  def handle_cast({:delete, key}, cache) do
    {:noreply, Map.delete(cache, key)}
  end

  def handle_cast(:clear, cache) do
    {:noreply, %{}}
  end

  def handle_call({:exist, key}, _from, cache) do
    {:reply, Map.has_key?(cache, key), cache}
  end

  def handle_call({:read, key}, _from, cache) do
    {:reply, Map.get(cache, key), cache}
  end

end
