defmodule ExTier.Plan do
  @moduledoc false
  defstruct [:title, :features, :currency, :interval]

  alias ExTier.Feature

  @type t :: %__MODULE__{
          title: String.t(),
          features: %{any() => [Feature.t()]},
          currency: String.t(),
          interval: String.t()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      title: params["title"],
      features: Map.new(params["features"], fn {name, feat} -> {name, Feature.new(feat)} end),
      currency: params["currency"],
      interval: params["interval"]
    }
  end
end
