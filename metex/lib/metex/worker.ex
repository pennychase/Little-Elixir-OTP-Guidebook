defmodule Metex.Worker do

  def temperature_of(location) do
    result = url_for(location) |> HTTPoison.get |> parse_response
    case result do
      {:ok, temp} -> "#{location}: #{temp} \u00b0C"
      {:error, msg}-> "Error retrieving temperature for #{location}: #{msg}"
    end
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

  def apikey do
    System.get_env("OPENWEATHER_API_KEY")
  end

end