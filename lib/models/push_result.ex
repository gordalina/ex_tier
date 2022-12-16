defmodule ExTier.PushResult do
  @moduledoc false
  defstruct [:feature, :reason, :status]

  require Logger

  @type t :: %__MODULE__{
          :feature => String.t(),
          :reason => String.t(),
          :status => String.t()
        }

  @type log_opts :: [
          already_exists_error?: boolean
        ]

  @spec new(map()) :: t
  def new(params) do
    %__MODULE__{
      feature: params["feature"],
      reason: params["reason"],
      status: params["status"]
    }
  end

  @spec log(t(), log_opts) :: :ok | :error
  def log(result, opts \\ [already_exists_error?: false])

  def log(%__MODULE__{status: "ok"} = result, _) do
    Logger.info("✔ #{result.reason}: #{result.feature}")
  end

  def log(%__MODULE__{} = result, opts) do
    if already_exists?(result, opts) do
      log(%__MODULE__{result | status: "ok"}, opts)
    else
      Logger.error("✘ #{result.reason}: #{result.feature} (#{result.status})")
      :error
    end
  end

  defp already_exists?(%__MODULE__{reason: reason}, opts) do
    Regex.match?(~r/already exists/, reason) && opts[:already_exists_error?] == false
  end
end
