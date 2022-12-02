defmodule ExTier.OrgInfo do
  @moduledoc false
  defstruct [:email, :name, :description, :phone, :metadata]

  @type t :: %__MODULE__{
          :email => String.t(),
          :name => String.t(),
          :description => String.t(),
          :phone => String.t(),
          :metadata => map()
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      email: params["email"],
      name: params["name"],
      description: params["description"],
      phone: params["phone"],
      metadata: params["metadata"]
    }
  end
end
