# PoolToy

The pooly application uses deprecacted Elixir features: the :simple_one_for_one strategy instead of the DynamicSupervisor
behavior, the Supervisor.Spec instead of using Supervisor child_specs, and no use of Registry to track workers.

David Sulc updated pooly as pool_toy. He walks through his implementation, icnlduedmattemptrs that didn't work, using 
observer to debug, etc. in a [series of blog posts](https://davidsulc.com/blog/pool-manager-elixir-dynamic-supervisor-registry-intro) and the full code is in his [GitHub repo](https://github.com/davidsulc/pool_toy).
https://davidsulc.com/blog/2018/07/09/pooltoy-a-toy-process-pool-manager-in-elixir-1-6/
I'm walking through the blog series and typing the code in by hand.

Sulc divided his series into two parts, a single pool and multiple pools. I'm implementing this in two branches:

- pool_toy-v1: Sulc's part 1. Implements pooly v1 and v2:
  - Single pool
  - Fixed number of workers
  - Recovery when consumer or worker processes fail
- pool_toy-v2: Sulc's part 2. Implements pooly v3 

