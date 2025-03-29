defmodule Chucky.Server do
  use GenServer

  #########
  ## API ##
  #########

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [name: {:global, __MODULE__}])
  end

  def fact do
    GenServer.call({:global, __MODULE__}, :fact)
  end

  ###############
  ## Callbacks ##
  ###############

  def init([]) do
    :rand.seed(:exsplus, :os.timestamp)
      facts =
        "facts.txt"
        |> File.read!()
        |> String.split("\n")

    {:ok, facts}
  end

  def handle_call(:fact, _from, facts) do
    random_fact =
      facts
      |> Enum.shuffle()
      |> List.first()
    {:reply, random_fact, facts}
  end

end
