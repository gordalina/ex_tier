defmodule ExTier.Api.LookupTest do
  use ExUnit.Case

  alias ExTier.Lookup

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "org" => "org:o",
            "stripe_id" => "cus_dq5fqwbdgE2GD",
            "email" => "org@example.com",
            "description" => "org",
            "name" => "organization",
            "phone" => "+1 (555) 123-8000",
            "metadata" => %{"id" => "org:o"}
          }
        }
    end)

    :ok
  end

  test "lookup/1" do
    assert {:ok, %Lookup{} = l} = ExTier.lookup(%{org: "org:o"})

    assert "org:o" == l.org
    assert "cus_dq5fqwbdgE2GD" == l.stripe_id
    assert "org@example.com" == l.email
    assert "org" == l.description
    assert "organization" == l.name
    assert "+1 (555) 123-8000" == l.phone
    assert %{"id" => "org:o"} == l.metadata
  end
end
