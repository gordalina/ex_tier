defmodule ExTier.Client.TierCloudMiddlewareTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias ExTier.Client

  describe "with tier cloud" do
    setup do
      Application.put_env(:ex_tier, :stripe_api_key, nil)
      on_exit(fn -> Application.put_env(:ex_tier, :stripe_api_key, nil) end)
    end

    test "enabled" do
      Application.put_env(:ex_tier, :stripe_api_key, "api-key")
      Tesla.Mock.mock(fn env -> %{env | status: 200, body: env.headers} end)
      assert {:ok, [{"authorization", "Basic YXBpLWtleTo="}]} == Client.get("/")
    end

    test "disabled" do
      Tesla.Mock.mock(fn env -> %{env | status: 200, body: env.headers} end)
      assert {:ok, []} == Client.get("/")
    end
  end
end
