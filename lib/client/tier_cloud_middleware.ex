defmodule ExTier.Client.TierCloudMiddleware do
  @moduledoc false

  @behaviour Tesla.Middleware

  require Logger

  @impl Tesla.Middleware
  def call(env, next, _options) do
    env
    |> Tesla.put_headers(authorization_header())
    |> Tesla.run(next)
  end

  defp authorization_header() do
    :ex_tier
    |> Application.fetch_env(:stripe_api_key)
    |> create_header()
  end

  defp create_header({:ok, nil}), do: []

  defp create_header({:ok, stripe_api_key}),
    do: [{"authorization", "Basic " <> Base.encode64(stripe_api_key <> ":")}]

  defp create_header(_), do: []
end
