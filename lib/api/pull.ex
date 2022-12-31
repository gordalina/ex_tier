defmodule ExTier.Api.Pull do
  @moduledoc ""
  alias ExTier.{Client, Error, Model, Utils}

  @doc """
  Get all pricing plans

      {:ok, %ExTier.Model{}} = ExTier.pull()

  """
  @spec pull() :: {:ok, Model.t()} | {:error, Error.t()}
  def pull() do
    Client.get("/pull") |> Utils.cast(Model)
  end

  @doc """
  Get the latest plan versions

      {:ok, %ExTier.Model{}} = ExTier.pull_latest()

  """
  @spec pull_latest() :: {:ok, Model.t()} | {:error, Error.t()}
  def pull_latest() do
    with {:ok, %Model{plans: plans}} <- pull(),
         latest <- Enum.reduce(plans, %{}, &latest_plan_version/2),
         plans <- Map.new(latest, fn {name, {_version, plan}} -> {name, plan} end) do
      {:ok, %Model{plans: plans}}
    else
      error -> error
    end
  end

  defp latest_plan_version({plan_name, plan}, acc) do
    [name, version] = plan_name |> String.split("@")
    version = String.to_integer(version)

    case Map.get(acc, name, nil) do
      nil ->
        Map.put(acc, name, {version, plan})

      {latest, _plan} when version > latest ->
        Map.put(acc, name, {version, plan})

      _ ->
        acc
    end
  end
end
