defmodule ExTier.Api.PullTest do
  use ExUnit.Case

  alias ExTier.{Model, Plan, Feature, FeatureTier}

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        body = %{
          "plans" => %{
            "plan:basic@0" => %{
              "features" => %{
                "feature:IncomingMessage" => %{"tiers" => [%{"price" => 8}]},
                "feature:OutgoingMessage" => %{"tiers" => [%{"price" => 8}]},
                "feature:PhoneNumber" => %{"tiers" => [%{"price" => 300}]}
              },
              "title" => "Basic"
            },
            "plan:basic@1" => %{
              "features" => %{
                "feature:IncomingMessage" => %{"tiers" => [%{"price" => 81}]},
                "feature:OutgoingMessage" => %{"tiers" => [%{"price" => 82}]},
                "feature:PhoneNumber" => %{"tiers" => [%{"price" => 3000}]}
              },
              "title" => "Basic"
            },
            "plan:basic@2" => %{
              "features" => %{
                "feature:IncomingMessage" => %{"tiers" => [%{"price" => 7}]},
                "feature:OutgoingMessage" => %{"tiers" => [%{"price" => 7}]},
                "feature:PhoneNumber" => %{"tiers" => [%{"price" => 30_000}]}
              },
              "title" => "Basic"
            }
          }
        }

        %Tesla.Env{status: 200, body: body}
    end)

    :ok
  end

  test "pull/1" do
    assert {:ok, %Model{} = model} = ExTier.pull()
    assert 3 == model.plans |> Map.keys() |> length()
    assert %Plan{features: features, title: "Basic"} = model.plans["plan:basic@0"]
    assert %Feature{tiers: [%FeatureTier{price: 8}]} = features["feature:IncomingMessage"]
  end

  test "pull_latest/1" do
    assert {:ok, %Model{} = model} = ExTier.pull_latest()
    assert 1 == model.plans |> Map.keys() |> length()
    assert %Plan{features: features, title: "Basic"} = model.plans["plan:basic"]
    assert %Feature{tiers: [%FeatureTier{price: 7}]} = features["feature:IncomingMessage"]
  end
end
