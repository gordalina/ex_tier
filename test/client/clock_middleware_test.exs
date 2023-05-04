defmodule ExTier.Client.ClockMiddlewareTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias ExTier.Client

  describe "with test clock" do
    setup do
      Application.put_env(:ex_tier, :clock_id, nil)
      on_exit(fn -> Application.put_env(:ex_tier, :clock_id, nil) end)
    end

    test "enabled" do
      Application.put_env(:ex_tier, :clock_id, "test_clock")
      Tesla.Mock.mock(fn env -> %{env | status: 200, body: env.headers} end)
      assert {:ok, [{"tier-clock", "test_clock"}]} == Client.get("/")
    end

    test "disabled" do
      Tesla.Mock.mock(fn env -> %{env | status: 200, body: env.headers} end)
      assert {:ok, []} == Client.get("/")
    end
  end
end
