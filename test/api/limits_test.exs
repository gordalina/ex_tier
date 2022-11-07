defmodule ExTier.Api.LimitsTest do
  use ExUnit.Case

  alias ExTier.{Limits, Usage}

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        body = %{
          "org" => "org:o",
          "usage" => [
            %{
              "feature" => "feature:f1",
              "limit" => 9_223_372_036_854_775_807,
              "used" => 0
            },
            %{
              "feature" => "feature:f2",
              "limit" => 9_223_372_036_854_775_807,
              "used" => 0
            },
            %{
              "feature" => "feature:f3",
              "limit" => 9_223_372_036_854_775_807,
              "used" => 0
            }
          ]
        }

        %Tesla.Env{status: 200, body: body}
    end)

    :ok
  end

  test "limits/1" do
    assert {:ok, %Limits{} = limits} = ExTier.limits(%{org: "org:o"})
    assert "org:o" == limits.org
    assert 3 == length(limits.usage)
  end

  test "limit/1" do
    assert {:ok, %Usage{} = usage} = ExTier.limit(%{org: "org:o", feature: "feature:f3"})

    assert "feature:f3" == usage.feature
    assert 9_223_372_036_854_775_807 == usage.limit
    assert 0 == usage.used
  end

  test "limit/1 with unknown feature" do
    assert {:ok, %Usage{} = usage} = ExTier.limit(%{org: "org:o", feature: "feature:unk"})

    assert "feature:unk" == usage.feature
    assert 0 == usage.limit
    assert 0 == usage.used
  end
end
