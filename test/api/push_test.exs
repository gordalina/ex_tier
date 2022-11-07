defmodule ExTier.Api.PushTest do
  use ExUnit.Case

  alias ExTier.{Push, PushResult}

  @json """
  {
    "plans": {
      "plan:basic@0": {
        "features": {
          "feature:IncomingMessage": {"tiers": [{"price": 8}]},
          "feature:OutgoingMessage": {"tiers": [{"price": 8}]},
          "feature:PhoneNumber": {"tiers": [{"price": 300}]}
        },
        "title": "Basic"
      },
      "plan:basic@1": {
        "features": {
          "feature:IncomingMessage": {"tiers": [{"price": 81}]},
          "feature:OutgoingMessage": {"tiers": [{"price": 82}]},
          "feature:PhoneNumber": {"tiers": [{"price": 3000}]}
        },
        "title": "Basic"
      },
      "plan:basic@2": {
        "features": {
          "feature:IncomingMessage": {"tiers": [{"price": 7}]},
          "feature:OutgoingMessage": {"tiers": [{"price": 7}]},
          "feature:PhoneNumber": {"tiers": [{"price": 300}]}
        },
        "title": "Basic"
      }
    }
  }
  """

  setup do
    Tesla.Mock.mock(fn
      %{method: :post} ->
        body = %{
          "results" => [
            %{
              "feature" => "feature:PhoneNumber@plan:basic@2",
              "reason" => "feature already exists",
              "status" => "ok"
            },
            %{
              "feature" => "feature:IncomingMessage@plan:basic@2",
              "reason" => "feature already exists",
              "status" => "ok"
            },
            %{
              "feature" => "feature:OutgoingMessage@plan:basic@2",
              "reason" => "feature already exists",
              "status" => "ok"
            }
          ]
        }

        %Tesla.Env{status: 200, body: body}
    end)

    :ok
  end

  test "pull/1" do
    assert {:ok, %Push{} = push} = ExTier.push(@json)
    assert 3 == push.results |> length()

    [%PushResult{} = result | _] = push.results

    assert "feature:PhoneNumber@plan:basic@2" == result.feature
    assert "feature already exists" == result.reason
    assert "ok" == result.status
  end
end
