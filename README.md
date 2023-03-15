# ExTier

[![Build Status](https://img.shields.io/github/actions/workflow/status/gordalina/ex_tier/ci.yml?branch=main&style=flat-square)](https://github.com/gordalina/ex_tier/actions?query=workflow%3A%22ci%22)
[![Coverage Status](https://img.shields.io/codecov/c/github/gordalina/ex_tier?style=flat-square)](https://app.codecov.io/gh/gordalina/ex_tier)
[![hex.pm version](https://img.shields.io/hexpm/v/ex_tier?style=flat-square)](https://hex.pm/packages/ex_tier)

ExTier is an elixir client for [Tier.run](https://tier.run), documentation can be found at [https://hexdocs.pm/ex_tier](https://hexdocs.pm/ex_tier).

## Installation

The package can be installed by adding `ex_tier` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_tier, "~> 0.6"}
  ]
end
```

### Versioning

ExTier follow's Tier's major and minor versions, but reserves minor versions for ExTier's patch updates. So Tier's `v0.6` version will map to ExTier `0.6.x` version.

## Configuration

### URL

You need to specify where the Tier server is reachable at:

```elixir
config :ex_tier, url: "http://localhost:8080"
```

### Test Clocks

To use test clocks, pass the clock_id in the configuration:

```elixir
config :ex_tier, clock_id: "clock_1xTl3FbwSFVVY4blLTlXv2CY"
```

### Tesla

ExTier depends on [Tesla](https://github.com/elixir-tesla/tesla) to perform HTTP requests. You are required to specify which Tesla adapter you want to use.

```elixir
config :ex_tier, adapter: Tesla.Adapter.Httpc,
```

You can also configure an adapter's options via:

```elixir
config :ex_tier, adapter: {Tesla.Adapter.Finch, name: ExTier}
```

## Compatibility

| ExTier     | Tier        | Erlang/OTP | Elixir       |
| -          | -           | -          | -            |
| `>= 0.0.0` | `>= 0.0.0`  | `>= 23.0.0` | `>= 1.14.0` |

## License

ExTier is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.
