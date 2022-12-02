defmodule ExTier.MixProject do
  use Mix.Project

  @version "0.6.0"
  @source_url "https://github.com/gordalina/ex_tier"

  def project do
    [
      app: :ex_tier,
      version: @version,
      elixir: "~> 1.14",
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      source_url: @source_url,
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.github": :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ],
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.0"},
      {:tesla, "~> 1.4"},
      {:mox, "~> 1.0", only: :test},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:dialyxir, "~> 1.2", only: :dev, runtime: false},
      {:ex_check, "~> 0.13", only: :dev, runtime: false},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: :test, runtime: false},
      {:sobelow, "~> 0.11", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["test/support"] ++ elixirc_paths(nil)
  defp elixirc_paths(_), do: ["lib"]

  defp description() do
    "A tier client for Elixir."
  end

  defp package() do
    [
      name: "ex_tier",
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
