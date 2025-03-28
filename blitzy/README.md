# Blitzy

#### Blitzy.Caller

Implements blizty with processes. Instead of modifying Blitzy.Worker to know the
caller process and send the results back, added the parallel map from _Programing Elixir_:

- The spawn argument function wraps a send around the "real" function, that goes to the process spawning the worker processes
- The function to the Enum.map that receives the results takes a process id (of the spawned process) as an argument, matches on it, and returns the message

#### Blitzy.run (defined in lib/blitzy.ex)

Implements blitzy with Tasks.

#### Blitz.CLI

Implements a CLI application that uses Tasks with a Task supervision tree. Except it doesn't work as a CLI. Apparently tzdata versions after 0.5 are incompatible with escripts (an incompatibility with ETS). But you can run it within IEx, after setting up the three slave nodes:
```elixir
Blitzy.CLI.main(["-n", "10", "http://www.bieberfever.com"]) 
```

