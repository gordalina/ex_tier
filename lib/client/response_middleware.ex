defmodule ExTier.Client.ResponseMiddleware do
  @moduledoc false

  @behaviour Tesla.Middleware

  require Logger

  @impl Tesla.Middleware
  def call(env, next, _options) do
    env
    |> Tesla.run(next)
    |> handle_response()
  end

  defp handle_response({:error, error}), do: {:error, error}
  defp handle_response({:ok, %{status: 200, body: "{}"}}), do: :ok
  defp handle_response({:ok, %{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %{status: status, body: body} = env}) do
    method = env.method |> Atom.to_string() |> String.upcase()
    Logger.error("ExTier: #{method} #{env.url} -> #{status}", error_metadata(env))
    {:error, body["code"]}
  end

  defp error_metadata(%Tesla.Env{} = env) do
    [
      request: [
        method: env.method,
        query: env.query
      ],
      response: [
        headers: env.headers,
        status: env.status,
        body: env.body
      ]
    ]
  end
end
