defmodule ExTier.Feature do
  @moduledoc false
  defstruct [:title, :base, :tiers, :mode]

  alias ExTier.FeatureTier

  @type mode :: :graduated | :volume
  @type t :: %__MODULE__{
          title: String.t(),
          base: non_neg_integer(),
          tiers: [FeatureTier.t()],
          mode: mode()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      title: params["title"],
      base: params["base"],
      tiers: Enum.map(params["tiers"], &FeatureTier.new/1),
      mode: params["mode"]
    }
  end
end
