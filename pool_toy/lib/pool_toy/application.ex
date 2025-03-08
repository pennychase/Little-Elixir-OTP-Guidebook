defmodule PoolToy.Application do
  @moduledoc """
  The PoolToy Applicatiom implements the Application behaviour.
  """

  use Application

  def start(_type, _args) do
    children =
      [
        {PoolToy.PoolSup, [size: 3]}
      ]

      opts = [strategy: :one_for_one]

      Supervisor.start_link(children, opts)
  end
  
end