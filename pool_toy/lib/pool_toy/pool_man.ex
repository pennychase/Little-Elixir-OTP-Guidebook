defmodule PoolToy.PoolMan do
  @moduledoc """
  The Pool Manager manages the pool of workers. It is implemented
  as a GenServer so it can maintain its state.
  """

  use GenServer

  @name __MODULE__

  #########
  ## API ##
  #########

  def start_link(size) when is_integer(size) and size > 0 do
    GenServer.start_link(__MODULE__, size, name: @name)
  end

  ###############
  ## Callbacks ##
  ###############

  def init(size) do
    state = List.duplicate(:worker, size)
    {:ok, state}
  end

end