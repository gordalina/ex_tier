defmodule ExTier.Model do
  @moduledoc false
  defstruct [:plans]

  alias ExTier.Plan

  @type t :: %__MODULE__{
          plans: %{
            any() => [Plan.t()]
          }
        }

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      plans: Map.new(params["plans"], fn {name, plan} -> {name, Plan.new(plan)} end)
    }
  end
end
