defmodule Chucky do
  use Application

  require Logger

  def start(type, _args) do
    children = [ {Chucky.Server, []} ]

    case type do
      :normal ->
        Logger.info("Application is started on #{Node.self()}")
      {:takeover, old_node} ->
        Logger.info("#{Node.self()} is taking over #{old_node}")
      {:failover, old_node} ->
        Logger.info("#{old_node} is failing over to #{Node.self()}")
    end

    opts = [strategy: :one_for_one, name: {:global, Chucky.Supervisor}]
    Supervisor.start_link(children, opts)
  end

  def fact do
    Chucky.Server.fact()
  end

end
