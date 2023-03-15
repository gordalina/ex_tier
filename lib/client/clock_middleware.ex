defmodule ExTier.Client.ClockMiddleware do
  @moduledoc false

  @behaviour Tesla.Middleware

  require Logger

  @impl Tesla.Middleware
  def call(env, next, _options) do
    env
    |> Tesla.put_headers(clock_header())
    |> Tesla.run(next)
  end

  defp clock_header() do
    Application.fetch_env(:ex_tier, :clock_id)
    |> create_header()
  end

  defp create_header({:ok, nil}), do: []
  defp create_header({:ok, clock_id}), do: [{"tier-clock", clock_id}]
  defp create_header(_), do: []
end
