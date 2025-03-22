# Blitzy

#### Blitzy.Caller

Implements blizty with processes. Instead of modifying Blitzy.Worker to know the
caller process and send the results back, added the parallel map from _Programing Elixir_:

- The spawn argument function wraps a send around the "real" function, that goes to the process spawning the worker processes
- The function to the Enum.map that receives the results takes a process id (of the spawned process) as an argument, matches on it, and returns the message

#### Blitzy.run (defined in lib/blitzy.ex)

Implements blitzy with Tasks.

