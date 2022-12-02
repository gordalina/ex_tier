defmodule ExTier do
  @moduledoc """
  ExTier is an elixir client for tier.run
  """

  alias ExTier.Api

  defdelegate limit(params), to: Api.Limits
  defdelegate limits(params), to: Api.Limits
  defdelegate lookup(params), to: Api.Lookup
  defdelegate phase(params), to: Api.Phase
  defdelegate pull(), to: Api.Pull
  defdelegate pull_latest(), to: Api.Pull
  defdelegate push(params), to: Api.Push
  defdelegate report(params), to: Api.Report
  defdelegate schedule(params), to: Api.Schedule
  defdelegate subscribe(params), to: Api.Subscribe
  defdelegate whoami(), to: Api.Whoami
  defdelegate whois(params), to: Api.Whois
end
