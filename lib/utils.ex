defmodule ExTier.Utils do
  @moduledoc false

  @spec to_datetime!(String.t()) :: DateTime.t()
  def to_datetime!(date_iso8601) do
    date_iso8601 |> NaiveDateTime.from_iso8601!() |> DateTime.from_naive!("Etc/UTC")
  end

  @spec cast({:ok, map()} | {:error, String.t()}, atom()) :: {:ok, struct()}
  def cast({:ok, json}, module) do
    json
    |> module.new()
    |> then(&{:ok, &1})
  rescue
    error ->
      {:error, Exception.message(error)}
  end

  def cast(other, _), do: other
end
