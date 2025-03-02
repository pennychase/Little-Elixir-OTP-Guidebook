# Pooly

Pooly is a worker pool application. We're buidling it in three version, with a git branch for each:

- **pooly-v1**
  - single pool
  - fixed number of workers
  - no recovery when consumer or worker processes fail
- **pooly-v2**
  - single pool
  - fixed number of workers
  - recovery when consumer or worker processes fail
- **pooly-v3**
  - multiple pools
  - variable number of workers
- **pooly-v4**
  - multiple pools
  - variable number of workers
  - variable-size pool allowsmfro worker overflow
  - queuing for consumer processes when all workers are busy

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pooly` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pooly, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/pooly>.

