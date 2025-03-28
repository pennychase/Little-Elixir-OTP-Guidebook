defmodule Blitzy.CLI do
    
    require Logger

    def main(args) do

      Application.get_env(:blitzy, :manager_node)
      |> Node.start()

      Application.get_env(:blitzy, :worker_nodes)
      |> Enum.each(&Node.connect(&1))

      args
      |> parse_args
      |> process_options([ Node.self() | Node.list()])
    end

    defp parse_args(args) do
      OptionParser.parse(args, aliases: [n: :requests], strict: [requests: :integer])
    end

    defp process_options(options, nodes) do
      case options do
        {[requests: n], [url], []} ->
          do_requests(n, url, nodes)
        _ -> do_help()
      end
    end

    def do_requests(n_requests, url, nodes) do
      Logger.info "Pummeling #{url} with #{n_requests}"

      total_nodes = Enum.count(nodes)
      req_per_node = div(n_requests, total_nodes)

      nodes
      |> Enum.flat_map(fn node ->
          1..req_per_node |> Enum.map(fn _ ->
            Task.Supervisor.async({Blitzy.TasksSupervisor, node}, Blitzy.Worker, :start, [url])
            end)
        end)
      |> Enum.map(&Task.await(&1, :infinity))
      |> Blitzy.parse_results


    end

    defp do_help do
      IO.puts """
      Usage: blitzy -n [requests] [url]

      Options:
      -n, [--requests]  # Number of requests

      Example:
      blitzy -n 100 http://www.bieberfever.com
      """
      System.halt(0)
    end
end