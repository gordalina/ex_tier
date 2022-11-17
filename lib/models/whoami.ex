defmodule ExTier.Whoami do
  @moduledoc false
  defstruct [:id, :email, :key_source, :isolated, :url]

  @type t :: %__MODULE__{
          id: String.t(),
          email: String.t(),
          key_source: String.t(),
          isolated: boolean(),
          url: String.t()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      id: params["id"],
      email: params["email"],
      key_source: params["key_source"],
      isolated: params["isolated"],
      url: params["url"]
    }
  end
end
