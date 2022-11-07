defmodule ExTier.CurrentPhase do
  @moduledoc false
  defstruct [:effective, :features, :plans]

  alias ExTier.Utils

  @type t :: %__MODULE__{
          effective: DateTime.t(),
          features: [String.t()],
          plans: [String.t()]
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      effective: Utils.to_datetime!(params["effective"]),
      features: params["features"],
      plans: params["plans"]
    }
  end
end
