defmodule ExTier.Client.ResponseMiddlewareTest do
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

  describe "tier error" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} = env ->
          body = %{"code" => "invalid"}

          %Tesla.Env{env | status: 400, body: body}
      end)

      :ok
    end

    test "invalid code" do
      assert capture_log(fn ->
               assert {:error, %ExTier.Error{status: 400, code: "invalid"}} = Client.get("/")
             end) =~ "ExTier: GET"
    end
  end

  describe "tesla error" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          {:error, "error"}
      end)

      :ok
    end

    test ":error" do
      assert {:error, "error"} = Client.get("/")
    end
  end
end
