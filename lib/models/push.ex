defmodule ExTier.Push do
  @moduledoc false
  defstruct [:results]

  alias ExTier.PushResult

  @type t :: %__MODULE__{
          :results => [PushResult.t()]
        }

  @type log_opts :: [
          already_exists_error?: boolean
        ]

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      results: Enum.map(params["results"], fn result -> PushResult.new(result) end)
    }
  end

  @spec log(t(), log_opts) :: :ok | :error
  def log(%__MODULE__{results: results}, opts \\ [already_exists_error?: false]) do
    results
    |> Enum.map(&PushResult.log(&1, opts))
    |> Enum.all?(fn res -> res == :ok end)
    |> case do
      true -> :ok
      false -> :error
    end
  end
end
