defmodule MP3IDParser do

  def parse(filename) do
    case File.read(filename) do
      { :ok, mp3} ->
        mp3_byte_size = byte_size(mp3) - 128

        <<_ :: binary-size(mp3_byte_size), id_tag :: binary >> = mp3

        <<"TAG", title :: binary-size(30),
                 artist :: binary-size(30),
                 album :: binary-size(30),
                 year :: binary-size(4),
                 _rest :: binary>> = id_tag

        # Trim zero padding
        title = String.trim title, <<0>>
        artist = String.trim artist, <<0>>
        album = String.trim album, <<0>>

        IO.puts "#{artist} - #{title} - (#{album}, #{year})"
      {:error, reason} -> IO.puts "Error reading #{filename}: #{reason}"
    end
  end
end
