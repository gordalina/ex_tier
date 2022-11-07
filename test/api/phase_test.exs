defmodule ExTier.Api.PhaseTest do
  use ExUnit.Case

  alias ExTier.CurrentPhase

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        body = %{
          "effective" => "2022-11-05T02:54:40Z",
          "features" => [
            "feature:IncomingMessage@plan:basic@0",
            "feature:OutgoingMessage@plan:basic@0",
            "feature:PhoneNumber@plan:basic@0"
          ],
          "plans" => ["plan:basic@0"]
        }

        %Tesla.Env{status: 200, body: body}
    end)

    :ok
  end

  test "phase/1" do
    assert {:ok, %CurrentPhase{} = phase} = ExTier.phase(%{org: "org:o"})
    assert %DateTime{} = phase.effective
    assert 3 == length(phase.features)
    assert 1 == length(phase.plans)
  end
end
