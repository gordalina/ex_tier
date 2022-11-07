defmodule ExTier.Client.ResponseMiddlewareTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias ExTier.Client

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
      assert capture_log(fn -> assert {:error, "invalid"} = Client.get("/") end) =~ "ExTier: GET"
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
