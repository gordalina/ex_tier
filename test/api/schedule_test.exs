defmodule ExTier.Api.ScheduleTest do
  use ExUnit.Case

  setup do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        %Tesla.Env{status: 200, body: "{}"}
    end)

    :ok
  end

  test "schedule/1" do
    params = %{org: "org:o", phases: [%{features: "feature:foo@plan:basic@2"}]}
    assert :ok = ExTier.schedule(params)
  end
end
