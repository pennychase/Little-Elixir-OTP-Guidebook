defmodule PoolToy do
  @moduledoc """
  Documentation for `PoolToy`.
  """

  defdelegate start_pool(args), to: PoolToy.PoolsSup

  # Example configuration
  def start_pools do
    PoolToy.start_pool(name: :pool1, worker_spec: Doubler, size: 3)
    PoolToy.start_pool(name: :pool2, worker_spec: Doubler, size: 2)
    PoolToy.start_pool(name: :pool3, worker_spec: Doubler, size: 4)
  end

end
