defmodule ExTier.Api.Limits do
  alias ExTier.{Client, Limits, Usage, Utils}

  @type limits_params :: %{
          :org => String.t()
        }

  @type limit_params :: %{
          :org => String.t(),
          :feature => String.t()
        }

  @doc """
  List the limits & usage of a given organization

      {:ok, %ExTier.Usage{}} = ExTier.limit(%{org: "org:org_id"})

  """
  @spec limits(limits_params) :: {:ok, Limits.t()} | {:error, String.t()}
  def limits(params) do
    Client.get("/limits", query: params) |> Utils.cast(Limits)
  end

  @doc """
  List the limits & usage of a given organization's feature

      {:ok, %ExTier.Usage{}} = ExTier.limit(%{org: "org:org_id", feature: "feature:feature_name"})

  """
  @spec limit(limit_params) :: {:ok, Usage.t()} | {:error, String.t()}
  def limit(params) do
    with {:ok, regex} <- Regex.compile("^#{params.feature}(@plan:.+)?$"),
         {:ok, limits} <- params |> Map.drop([:feature]) |> limits() do
      limits.usage
      |> Enum.find(&String.match?(&1.feature, regex))
      |> case do
        nil ->
          {:ok, %Usage{feature: params.feature, used: 0, limit: 0}}

        usage ->
          {:ok, usage}
      end
    else
      error -> error
    end
  end
end
