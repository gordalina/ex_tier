defmodule ExTier.Api.WhoisTest do
  use ExUnit.Case

  alias ExTier.Whois

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: %{
            "org" => "org:o",
            "stripe_id" => "cus_dq5fqwbdgE2GD"
          }
        }
    end)

    :ok
  end

  test "whois/1" do
    assert {:ok, %Whois{org: org, stripe_id: sid}} = ExTier.whois(%{org: "org:o"})

    assert "org:o" == org
    assert "cus_dq5fqwbdgE2GD" = sid
  end
end
