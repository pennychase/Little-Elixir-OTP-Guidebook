defmodule PoolToy.WorkerSup do
  @moduledoc """
  WorkerSup supervises the worker pool. It is implmented as a
  DynamicSupervisor, so the workers can be created dynamically.
  """
  use DynamicSupervisor, restart: :temporary

  #########
  ## API ##
  #########

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args)
  end

 defdelegate start_worker(sup, spec), to: DynamicSupervisor, as: :start_child

 defdelegate terminate_child(sup, pid), to: DynamicSupervisor, as: :terminate_child
 
  ###############
  ## Callbacks ##
  ###############

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

end