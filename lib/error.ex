defmodule ExTier.Error do
  defstruct [:status, :code, :message]

  @type t :: %__MODULE__{
          status: non_neg_integer(),
          code: String.t(),
          message: String.t()
        }
end
