defmodule Metex.Worker do

  use GenServer

  @name MW

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def get_temperature(location) do
    GenServer.call(@name, {:location, location})
  end

  def get_stats() do
    GenServer.call(@name, :get_stats)
  end

  def reset_stats() do
    GenServer.cast(@name, :reset_stats)
  end

  def stop() do
    GenServer.cast(@name, :stop)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def terminate(reason, stats) do
    IO.puts "Server terminated because of #{reason}"
    IO.inspect(stats)
    :ok
  end

  def handle_call({:location, location}, _from, stats) do
    case temperature_of(location) do
      {:ok, temp} ->
        new_stats = update_stats(stats, location)
        {:reply, "#{temp}°C", new_stats}
      _ -> 
        {:reply, :error, stats}
    end
  end

  def handle_call(:get_stats, _from, stats) do
    {:reply, stats, stats}
  end

  def handle_cast(:reset_stats, _stats) do
    {:noreply, %{}}
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end

  ## Helper Functions

  def temperature_of(location) do
    url_for(location) |> HTTPoison.get |> parse_response
  end

  def url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature   
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: _status}}) do
    { :error, "HTTP error: #{body}"} 
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, inspect reason}
  end

  def compute_temperature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15 |> Float.round(1))
      {:ok, temp}
    rescue
      _ -> {:error, "Unable to process temperature"}
    end
  end

  def update_stats(old_stats, location) do
    case Map.has_key?(old_stats, location) do
      true -> Map.update!(old_stats, location, &(&1 + 1))
      false -> Map.put_new(old_stats, location, 1)
    end
  end

  def apikey do
    System.get_env("OPENWEATHER_API_KEY")
  end

end