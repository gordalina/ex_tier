import Config

config :ex_tier,
  adapter: Tesla.Mock,
  url: "http://localhost:8080"

config :logger, backends: []
