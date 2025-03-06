# PoolToy

The pooly application uses depracted Elixir features: the :simple_one_for_one strategy instead of the DynamicSupervisor
behavior, the Supervisor.Spec instead of using Supervisor child_specs, and no use of Regsitry to tarck workers.

David Sulc updated pooly as pool_toy. He walks through his implementation, icnlduedmattemptrs that didn't work, using 
observer to debug, etc. in a [series of blog posts](https://davidsulc.com/blog/pool-manager-elixir-dynamic-supervisor-registry-intro) and the full code is in his [GitHub repo](https://github.com/davidsulc/pool_toy).

I'm walking through the blog series and typing the code in by hand.


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/pool_toy>.

