defmodule ExTier.Api.PullTest do
  use ExUnit.Case

  alias ExTier.{Model, Plan, Feature, FeatureTier}

  @body %{
    "plans" => %{
      "plan:basic@0" => %{
        "features" => %{
          "feature:IncomingMessage" => %{"tiers" => [%{"price" => 8}]},
          "feature:OutgoingMessage" => %{"tiers" => [%{"price" => 8}]},
          "feature:PhoneNumber" => %{"tiers" => [%{"price" => 300}]}
        },
        "title" => "Basic"
      },
      "plan:basic@32" => %{
        "features" => %{
          "feature:IncomingMessage" => %{"tiers" => [%{"price" => 7}]},
          "feature:OutgoingMessage" => %{"tiers" => [%{"price" => 7}]},
          "feature:PhoneNumber" => %{"tiers" => [%{"price" => 30_000}]}
        },
        "title" => "Basic"
      },
      "plan:basic@31" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@30" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@29" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@28" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@27" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@26" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@25" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@24" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@23" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@22" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@21" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@20" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@19" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@18" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@17" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@16" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@15" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@14" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@13" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@12" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@11" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@10" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@8" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@9" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@7" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@6" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@5" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@4" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@3" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@2" => %{"features" => %{}, "title" => "Basic"},
      "plan:basic@1" => %{"features" => %{}, "title" => "Basic"}
    }
  }

  describe "ok" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: @body}
      end)

      :ok
    end

    test "pull/1" do
      assert {:ok, %Model{} = model} = ExTier.pull()
      assert 33 == model.plans |> Map.keys() |> length()

      plan = model.plans["plan:basic@0"]
      assert "plan:basic@0" == plan.plan
      assert "Basic" == plan.title
      assert %Feature{tiers: [%FeatureTier{price: 8}]} = plan.features["feature:IncomingMessage"]
    end

    test "pull_latest/1" do
      assert {:ok, %Model{} = model} = ExTier.pull_latest()
      assert 1 == model.plans |> Map.keys() |> length()

      plan = model.plans["plan:basic"]
      assert "plan:basic@32" == plan.plan
      assert "Basic" == plan.title
      assert %Feature{tiers: [%FeatureTier{price: 7}]} = plan.features["feature:IncomingMessage"]
    end
  end

  describe "error" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 400, body: %{"code" => "invalid"}}
      end)

      :ok
    end

    test "pull_latest/0" do
      assert {:error, "invalid"} == ExTier.pull_latest()
    end
  end
end
