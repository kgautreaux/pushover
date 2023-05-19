defmodule Pushover.MixProject do
  use Mix.Project

  @version "0.4.8"

  def project do
    [
      app: :pushover,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  def description do
    "Pushover API Client for Elixir"
  end

  def package do
    [
      name: "pushover",
      maintainers: ["Keith Gautreaux"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kgautreaux/pushover"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.7"},
      {:google_gax, "~> 0.4.1"},

      # Docs
      {:ex_doc, "~> 0.29.0", only: :dev, runtime: false}
    ]
  end
end
