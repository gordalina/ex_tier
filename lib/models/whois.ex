defmodule ExTier.Whois do
  @moduledoc false
  defstruct [:org, :stripe_id]

  @type t :: %__MODULE__{
          :org => String.t(),
          :stripe_id => String.t()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      org: params["org"],
      stripe_id: params["stripe_id"]
    }
  end
end
