defmodule Alphavantagex.MixProject do
  use Mix.Project

  def project do
    [
      app: :alphavantagex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Alphavantagex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:tesla, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:csv, "~> 2.0"},
      {:nimble_csv, "~> 0.1"},
      {:map_keys, "~> 0.1"},
      {:construct, "~> 1.0"}
    ]
  end
end
