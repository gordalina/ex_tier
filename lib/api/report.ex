defmodule ExTier.Api.Report do
  alias ExTier.Client

  @type report_params :: %{
          :org => String.t(),
          :feature => String.t(),
          optional(:n) => float(),
          optional(:at) => DateTime.t(),
          optional(:clobber) => boolean()
        }

  @doc """
  Report usage of a given feature in an organization

      :ok = ExTier.report(%{org: "org:org_id", feature: "feature:feature"})

  """
  @spec report(report_params) :: :ok | {:error, String.t()}
  def report(params) do
    params =
      params
      |> Map.replace_lazy(:at, &DateTime.to_iso8601/1)
      |> Map.put_new(:n, 1)

    Client.post("/report", params)
  end
end
