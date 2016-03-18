defmodule Senpai.Mixfile do
  use Mix.Project

  def project do
    [app: :senpai,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :plug],
     mod: {Senpai, []}]
  end

  defp deps do
    [{:dialyze, "~> 0.2.0"},
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 0.12"},
     {:poison, "~> 1.4.0"}]
  end
end
