defmodule ExTier.Client do
  @moduledoc false

  use Tesla

  adapter(fn env ->
    {adapter, opts} =
      case Application.fetch_env!(:ex_tier, :adapter) do
        {adapter, opts} -> {adapter, opts}
        adapter -> {adapter, []}
      end

    apply(adapter, :call, [env, opts])
  end)

  plug(ExTier.Client.TierCloudMiddleware)
  plug(ExTier.Client.ClockMiddleware)
  plug(ExTier.Client.ResponseMiddleware)

  plug(Tesla.Middleware.Retry, max_retries: 3)
  plug(Tesla.Middleware.BaseUrl, "#{Application.fetch_env!(:ex_tier, :url)}/v1")
  plug(Tesla.Middleware.JSON)
end
