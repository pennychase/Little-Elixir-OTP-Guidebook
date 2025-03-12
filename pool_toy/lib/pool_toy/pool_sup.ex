defmodule PoolToy.PoolSup do

  @moduledoc """
  The Pool Supervisor supervises the
  Pool Manager and Worker Supervisor. It uses the :one_for_all
  strategy to ensure that if one of its child processes die, all other
  processes are killed before restarting (to ensure that all the workers are
  valid processes).
  """
  use Supervisor

  #########
  ## API ##
  #########

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)   
  end

  ###############
  ## Callbacks ##
  ###############

  def init(args) do

    children =
      [
        {PoolToy.PoolMan, [{:pool_sup, self()} | args]}
      ]

    Supervisor.init(children, strategy: :one_for_all)
  end
  
end