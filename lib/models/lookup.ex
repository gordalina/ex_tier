defmodule ExTier.Lookup do
  @moduledoc false
  defstruct [
    # Whois
    :org,
    :stripe_id,

    # OrgInfo
    :email,
    :name,
    :description,
    :phone,
    :metadata
  ]

  alias ExTier.{OrgInfo, Whois}

  @type t :: %__MODULE__{
          # Whois
          :org => String.t(),
          :stripe_id => String.t(),

          # OrgInfo
          :email => String.t(),
          :name => String.t(),
          :description => String.t(),
          :phone => String.t(),
          :metadata => map()
        }

  @spec new(map()) :: t
  def new(params) do
    params =
      Whois.new(params)
      |> Map.merge(OrgInfo.new(params))
      |> Map.from_struct()

    struct!(__MODULE__, params)
  end
end
