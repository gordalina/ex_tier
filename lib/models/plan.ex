defmodule ExTier.Plan do
  @moduledoc false
  defstruct [:name, :title, :features, :currency, :interval]

  alias ExTier.Feature

  @type t :: %__MODULE__{
          name: String.t(),
          title: String.t(),
          features: %{any() => [Feature.t()]},
          currency: String.t(),
          interval: String.t()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      name: params["name"],
      title: params["title"],
      features: Map.new(params["features"], fn {name, feat} -> {name, Feature.new(feat)} end),
      currency: params["currency"],
      interval: params["interval"]
    }
  end
end
