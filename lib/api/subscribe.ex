defmodule ExTier.Api.Subscribe do
  alias ExTier.{Client, Phase}

  @type subscribe_params :: %{
          :org => String.t(),
          :features => Phase.features() | [Phase.features()],
          :effective => DateTime.t()
        }

  @doc """
  Subscribe an organization to a plan or a set of features

      :ok = ExTier.schedule(%{org: "org:org_id", features: ["plan:my_plan@0"]})
      :ok = ExTier.schedule(%{org: "org:org_id", features: ["feature:feature@plan:my_plan@0"]})

  """
  @spec subscribe(subscribe_params) :: :ok | {:error, String.t()}
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
end
