defmodule ExTier.Api.SubscribeTest do
  use ExUnit.Case

  setup do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        %Tesla.Env{status: 200, body: "{}"}
    end)

    :ok
  end

  test "subscribe/1 with feature" do
    assert :ok = ExTier.subscribe(%{org: "org:o", features: "plan:basic@2"})
  end

  test "subscribe/1 with features" do
    dt = DateTime.utc_now()
    features = ["feature:IncomingMessage", "feature:IncomingMessage"]
    assert :ok = ExTier.subscribe(%{org: "org:o", features: features, effective: dt})
  end
end
