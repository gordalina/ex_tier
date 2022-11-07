defmodule ExTier.Limits do
  @moduledoc false
  defstruct [:org, :usage]

  alias ExTier.Usage

  @type t :: %__MODULE__{
          org: String.t(),
          usage: [Usage.t()]
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      org: params["org"],
      usage: Enum.map(params["usage"], &Usage.new/1)
    }
  end
end
