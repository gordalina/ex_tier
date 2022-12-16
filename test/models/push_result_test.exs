defmodule ExTier.Models.PushResultTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  require Logger

  alias ExTier.PushResult

  @ok %PushResult{
    feature: "feature:PhoneNumber@plan:basic@2",
    reason: "created",
    status: "ok"
  }

  @exists %PushResult{
    feature: "feature:IncomingMessage@plan:basic@2",
    reason: "feature already exists",
    status: "failed"
  }

  @error %PushResult{
    feature: "feature:OutgoingMessage@plan:basic@2",
    reason: "could not create feature",
    status: "failed"
  }

  test "log/2" do
    assert :ok = PushResult.log(@ok)
    assert :ok = PushResult.log(@exists, already_exists_error?: false)
    assert :error = PushResult.log(@exists, already_exists_error?: true)
    assert :error = PushResult.log(@error)
    assert :error = PushResult.log(@error, already_exists_error?: false)
    assert :error = PushResult.log(@error, already_exists_error?: true)

    {_, created} = with_log(fn -> PushResult.log(@ok) end)
    {_, failed_ok} = with_log(fn -> PushResult.log(@exists, already_exists_error?: false) end)
    {_, failed_error} = with_log(fn -> PushResult.log(@exists, already_exists_error?: true) end)
    {_, error} = with_log(fn -> PushResult.log(@error) end)

    assert created =~ "✔ created: feature:PhoneNumber@plan:basic"
    assert failed_ok =~ "✔ feature already exists: feature:IncomingMessage@plan:basic@2"
    assert failed_error =~ "✘ feature already exists: feature:IncomingMessage@plan:basic@2"
    assert error =~ "✘ could not create feature: feature:OutgoingMessage@plan:basic@2"
  end
end
