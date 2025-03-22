defmodule Blitzy.Caller do

    def start(n_workers, url) do
      me = self()

      1..n_workers
        |> Enum.map(fn _ -> 
                spawn(fn -> (send me, {self(), Blitzy.Worker.start(url)}) end)
            end)
        |> Enum.map(fn pid->
                receive do {^pid, x }-> x end
           end)   
    end
    
end
