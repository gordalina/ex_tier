defmodule ExTier.PushResult do
  @moduledoc false
  defstruct [:feature, :reason, :status]

  @type t :: %__MODULE__{
          :feature => String.t(),
          :reason => String.t(),
          :status => String.t()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      feature: params["feature"],
      reason: params["reason"],
      status: params["status"]
    }
  end
end
