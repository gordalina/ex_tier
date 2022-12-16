defmodule ExTier.Models.PushTest do
  use ExUnit.Case

  alias ExTier.{Push, PushResult}

  @push %Push{
    results: [
      %PushResult{
        feature: "feature:PhoneNumber@plan:basic@2",
        reason: "created",
        status: "ok"
      },
      %PushResult{
        feature: "feature:IncomingMessage@plan:basic@2",
        reason: "feature already exists",
        status: "failed"
      },
      %PushResult{
        feature: "feature:OutgoingMessage@plan:basic@2",
        reason: "feature already exists",
        status: "failed"
      }
    ]
  }

  test "log/2" do
    assert :ok = Push.log(@push)
    assert :ok = Push.log(@push, already_exists_error?: false)
    assert :error = Push.log(@push, already_exists_error?: true)
  end
end
