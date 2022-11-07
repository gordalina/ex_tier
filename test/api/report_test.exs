defmodule ExTier.Api.ReportTest do
  use ExUnit.Case

  setup do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        %Tesla.Env{status: 200, body: "{}"}
    end)

    :ok
  end

  test "report/1 with org" do
    assert :ok = ExTier.report(%{org: "org:o"})
  end

  test "report/1 with org and feature" do
    assert :ok = ExTier.report(%{org: "org:o", feature: "feature:f"})
  end
end
