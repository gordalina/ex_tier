defmodule ExTier.Api.Lookup do
  alias ExTier.{Client, Utils, Lookup}

  @type lookup_params :: %{
          :org => String.t()
        }

  @doc """
  Get Stripe's customer id from an organization

      {:ok, %ExTier.Lookup{}} = ExTier.lookup(%{org: "org:org_id"})

  """
  @spec lookup(lookup_params) :: {:ok, Lookup.t()} | {:error, String.t()}
  def lookup(params) do
    Client.get("/whois", query: Map.put(params, :include, "info")) |> Utils.cast(Lookup)
  end
end
