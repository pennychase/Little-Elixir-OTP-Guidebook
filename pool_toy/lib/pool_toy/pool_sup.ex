defmodule PoolToy.PoolSup do

  @moduledoc """
  The Pool Supervisor supervises the
  Pool Manager and Worker Supervisor. It uses the :one_for_all
  strategy to ensure that if one of its child processes die, all other
  processes are killed before restarting (to ensure that all the workers are
  valid processes).
  """

  use Supervisor

  @name __MODULE__

  #########
  ## API ##
  #########

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: @name)   
  end

  ###############
  ## Callbacks ##
  ###############

  def init(args) do
    pool_size = args 
                |> Keyword.fetch!(:size)

    children =
      [
         {PoolToy.PoolMan, pool_size},
         PoolToy.WorkerSup
      ]

    Supervisor.init(children, strategy: :one_for_all)
  end
  
end