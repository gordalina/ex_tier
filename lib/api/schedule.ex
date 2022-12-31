defmodule ExTier.Api.Schedule do
  alias ExTier.{Client, Error, Phase}

  @type schedule_params :: %{
          :org => String.t(),
          :phases => [Phase.t()]
        }

  @doc """
  Schedule a phase in an organization

      :ok = ExTier.schedule(%{org: "org:org_id", phases: [%{features: ["feature:feature"]}]})

  """
  @spec schedule(schedule_params) :: :ok | {:error, Error.t()}
  def schedule(%{phases: _} = params) do
    Client.post("/subscribe", params)
  end
end
