defmodule ExTier.Api.Whois do
  alias ExTier.{Client, Utils, Whois}

  @type whois_params :: %{
          :org => String.t()
        }

  @doc """
  Get Stripe's customer id from an organization

      {:ok, %ExTier.Whois{}} = ExTier.whois(%{org: "org:org_id"})

  """
  @spec whois(whois_params) :: {:ok, Whois.t()} | {:error, String.t()}
  def whois(params) do
    Client.get("/whois", query: params) |> Utils.cast(Whois)
  end
end
