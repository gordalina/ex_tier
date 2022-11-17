defmodule ExTier.Api.WhoamiTest do
  use ExUnit.Case

  alias ExTier.Whoami

  @whoami %{
    "id" => "acct_abcdef",
    "email" => "email",
    "created" => "1970-01-01T00:00:00Z",
    "key_source" => "STRIPE_API_KEY",
    "isolated" => false,
    "url" => "https://dashboard.stripe.com/acct_abcdef"
  }

  setup do
    Tesla.Mock.mock(fn
      %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: @whoami
        }
    end)

    :ok
  end

  test "whoami/1" do
    assert {:ok, %Whoami{} = whoami} = ExTier.whoami()

    assert "acct_abcdef" == whoami.id
    assert "email" == whoami.email
    assert "STRIPE_API_KEY" == whoami.key_source
    assert false == whoami.isolated
    assert "https://dashboard.stripe.com/acct_abcdef" == whoami.url
  end
end
