defmodule ExTier.Api.Phase do
  alias ExTier.{Client, CurrentPhase, Error, Utils}

  @type phase_params :: %{
          org: String.t()
        }

  @doc """
  Get the current phase an organization is on

      {:ok, %ExTier.CurrentPhase{}} = ExTier.phase(%{org: "org:org_id"})

  """
  @spec phase(phase_params) :: {:ok, CurrentPhase.t()} | {:error, Error.t()}
  def phase(params) do
    Client.get("/phase", query: params) |> Utils.cast(CurrentPhase)
  end
end
