defmodule ExTier.FeatureTier do
  @moduledoc false
  defstruct [:upto, :price, :base]

  @type t :: %__MODULE__{
          upto: non_neg_integer(),
          price: non_neg_integer(),
          base: non_neg_integer()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      upto: params["upto"],
      price: params["price"],
      base: params["base"]
    }
  end
end
