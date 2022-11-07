defmodule ExTier.Push do
  @moduledoc false
  defstruct [:results]

  alias ExTier.PushResult

  @type push_result :: %{
          feature: String.t(),
          status: String.t(),
          reason: String.t()
        }

  @type t :: %__MODULE__{
          :results => [PushResult.t()]
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      results: Enum.map(params["results"], fn result -> PushResult.new(result) end)
    }
  end
end
