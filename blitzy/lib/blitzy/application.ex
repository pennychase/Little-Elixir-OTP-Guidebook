defmodule Blitzy.Application do

  use Application

  def start(_type, _arg) do
    Blitzy.Supervisor.start_link(:ok)
  end
    
end