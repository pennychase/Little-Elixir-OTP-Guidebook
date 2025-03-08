defmodule PoolToy.WorkerSup do
  @moduledoc """
  WorkerSup supervises the worker pool. It is implmented as a
  DynamicSupervisor, so the workers can be created dynamically.
  """
  use DynamicSupervisor

  @name __MODULE__

  #########
  ## API ##
  #########

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: @name)
  end

  ###############
  ## Callbacks ##
  ###############

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

end