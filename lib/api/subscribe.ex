defmodule ExTier.Api.Subscribe do
  alias ExTier.{Client, Error, OrgInfo, Phase}

  @type subscribe_features_params :: %{
          :org => String.t(),
          :features => Phase.features() | [Phase.features()],
          :effective => DateTime.t(),
          optional(:info) => OrgInfo.t()
        }

  @type subscribe_features_info :: %{
          :org => String.t(),
          optional(:features) => Phase.features() | [Phase.features()],
          optional(:effective) => DateTime.t(),
          :info => OrgInfo.t()
        }

  @type subscribe_params :: subscribe_features_params() | subscribe_features_info()

  @doc """
  Subscribe an organization to a plan or a set of features

      :ok = ExTier.schedule(%{org: "org:org_id", features: ["plan:my_plan@0"]})
      :ok = ExTier.schedule(%{org: "org:org_id", features: ["feature:feature@plan:my_plan@0"]})
      :ok = ExTier.schedule(%{org: "org:org_id", info: %{email: "org@example.com"}})

  """
  @spec subscribe(subscribe_params) :: :ok | {:error, Error.t()}
  def subscribe(%{features: features} = params) when not is_list(features) do
    params
    |> Map.replace_lazy(:features, &List.wrap/1)
    |> subscribe()
  end

  def subscribe(%{features: _} = params) do
    phases = Map.take(params, [:features, :effective])

    params =
      %{org: params.org}
      |> Map.put(:phases, [phases])

    Client.post("/subscribe", params)
  end

  def subscribe(params) do
    Client.post("/subscribe", params)
  end
end
