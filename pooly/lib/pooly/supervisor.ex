defmodule Pooly.Supervisor do
  use Supervisor

  #########
  ## API ##
  #########

  def start_link(pool_config) do
    Supervisor.start_link(__MODULE__, pool_config)
  end
  
  ###############
  ## Callbacks ##
  ###############

  def init(pool_config) do
    children = [
      worker(Pooly.Server, [self(), pool_config])
    ]

    opts = [strategy: :one_for_all]

    supervise(children, opts)
  end
end