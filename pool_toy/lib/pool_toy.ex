defmodule PoolToy do
  @moduledoc """
  Documentation for `PoolToy`.
  """
  @timeout 5000

  defdelegate start_pool(args), to: PoolToy.PoolsSup

  defdelegate stop_pool(args), to: PoolToy.PoolsSup

  def checkout(pool, block \\ true, timeout \\ @timeout) do
    PoolToy.PoolMan.checkout(pool, block, timeout)
  end

  def checkin(pool, worker) do
    PoolToy.PoolMan.checkin(pool, worker)
  end

  defdelegate status(args), to: PoolToy.PoolMan

  # Example configuration
  def start_pools do
    PoolToy.start_pool(name: :pool1, worker_spec: Doubler, size: 3, max_overflow: 0)
    PoolToy.start_pool(name: :pool2, worker_spec: Doubler, size: 2, max_overflow: 2)
    PoolToy.start_pool(name: :pool3, worker_spec: Doubler, size: 4, max_overflow: 0)
  end

end
