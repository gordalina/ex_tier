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

  test "subscribe/1 with phase" do
    phase = %{
      features: ["feature:IncomingMessage", "feature:IncomingMessage"],
      effective: DateTime.utc_now()
    }

    assert :ok = ExTier.subscribe(%{org: "org:o", phases: phase})
  end

  test "subscribe/1 with only org info" do
    params = %{
      org: "org:o",
      email: "org@example.com",
      description: "org",
      name: "organization",
      phone: "+1 (555) 123-8000",
      metadata: %{"id" => "org:o"}
    }

    assert :ok = ExTier.subscribe(params)
  end
end
