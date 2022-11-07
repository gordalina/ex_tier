defmodule ExTier.Phase do
  @moduledoc false
  defstruct [:effective, :features]

  alias ExTier.Utils

  @type plan_name :: String.t()
  @type versioned_feature_name :: String.t()
  @type features :: plan_name() | versioned_feature_name()

  @type t :: %__MODULE__{
          effective: DateTime.t(),
          features: [features()]
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      effective: Utils.to_datetime!(params["effective"]),
      features: params["features"]
    }
  end
end
