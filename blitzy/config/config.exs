import Config

config :blitzy, manager_node: :"a@127.0.0.1"

config :blitzy, worker_nodes: [:"b@127.0.0.1",
                               :"c@127.0.0.1",
                               :"d@127.0.0.1"
                             ]