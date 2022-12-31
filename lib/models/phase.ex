defmodule ExTier.Phase do
  @moduledoc false
  defstruct [:effective, :features, :trial]

  @type plan_name :: String.t()
  @type versioned_feature_name :: String.t()
  @type features :: plan_name() | versioned_feature_name()

  @type t :: %__MODULE__{
          effective: DateTime.t(),
          features: [features()],
          trial: boolean()
        }
end
