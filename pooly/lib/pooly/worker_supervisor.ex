defmodule Pooly.WorkerSupervisor do

  use Supervisor

  #########
  ## API ##
  #########

  def start_link({_,_,_} = mfa) do
    Supervisor.start_link(__MODULE__, mfa)
  end


  ###############
  ## Callbacks ##
  ###############

  def init({m, f, a}) do
    worker_opts = [restart: :permanent, function: f]
    children = [worker(m, a, worker_opts)]
    opts = [strategy: :simple_one_for_one,
            max_restarts: 5,
            max_seconds: 5]

    supervise(children, opts)
  end
  
end