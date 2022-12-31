defmodule ExTier.Api.Push do
  alias ExTier.{Client, Error, Model, Push, Utils}

  @type push_params :: %{
          :model => Model.t()
        }

  @doc """
  Create or update pricing plans

      {:ok, %ExTier.Api.Push{}} = File.read!("pricing.json") |> ExTier.push()

  """
  @spec push(push_params) :: {:ok, Push.t()} | {:error, Error.t()}
  def push(params) do
    Client.post("/push", params) |> Utils.cast(Push)
  end
end
