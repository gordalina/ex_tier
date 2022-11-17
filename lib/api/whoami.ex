defmodule ExTier.Api.Whoami do
  alias ExTier.{Client, Utils, Whoami}

  @doc """
  Get Stripe's customer id from an organization

      {:ok, %ExTier.Whois{}} = ExTier.schedule(%{org: "org:org_id"})

  """
  @spec whoami() :: {:ok, Whoami.t()} | {:error, String.t()}
  def whoami() do
    Client.get("/whoami") |> Utils.cast(Whoami)
  end
end
