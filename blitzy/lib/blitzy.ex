defmodule Blitzy do
  @moduledoc """
  `Blitzy` provides convenience functions to run workers and generate statistics.
  """

 def run(n_workers, url) when n_workers > 0 do

    worker_fun = fn -> Blitzy.Worker.start(url) end

    1..n_workers
      |> Enum.map(fn _ -> Task.async(worker_fun) end)
      |> Enum.map(&Task.await(&1, :infinity))
  end

  def stats(results) do
    {successes, _failures} =
      results |> Enum.split_with(fn x ->
        case x do
          {:ok, _} -> true
          _        -> false
        end
      end)

    total_workers = Enum.count(results)
    total_success = Enum.count(successes)
    total_failure = total_workers - total_success

    data = successes |> Enum.map(fn {:ok, time} -> time end)
    average_time = average(data)
    longest_time = Enum.max(data)
    shortest_time = Enum.min(data)

    IO.puts """
    Total workers   : #{total_workers}
    Successful res  : #{total_success}
    Failed res      : #{total_failure}
    Average (msec)  : #{average_time}
    Longest (msec)  : #{longest_time}
    Shortest (msec) : #{shortest_time}
    """
  end

  defp average(list) do
    sum = Enum.sum(list)
    if sum > 0 do
      sum / Enum.count(list)
    else
     0
    end
  end

end
