defmodule ExTier.UtilsTest do
  use ExUnit.Case

  alias ExTier.Utils

  test "cast error" do
    assert :error == Utils.cast(:error, :unused)
  end

  test "cast exception" do
    assert match?({:error, _}, Utils.cast({:ok, %{"error" => "yes"}}, :invalid))
  end
end
