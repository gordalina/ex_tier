defmodule ExTier.Usage do
  @moduledoc false
  defstruct [:feature, :used, :limit]

  @type t :: %__MODULE__{
          feature: String.t(),
          used: float(),
          limit: float()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      feature: params["feature"],
      used: params["used"],
      limit: params["limit"]
    }
  end
end
