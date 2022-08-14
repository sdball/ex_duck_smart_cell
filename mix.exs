defmodule ExDuckSmartCell.MixProject do
  use Mix.Project

  @version "0.1.1"
  @github "https://github.com/sdball/ex_duck_smart_cell"

  def project do
    [
      app: :ex_duck_smart_cell,
      version: @version,
      elixir: "~> 1.13",
      description: "ExDuckSmartCell is a Livebook smart cell interface to ExDuck.",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ExDuckSmartCell",
      source_url: @github,
      package: package(),
      docs: docs(),
    ]
  end

  def application do
    [
      mod: {ExDuckSmartCell.Application, []}
    ]
  end

  defp deps do
    [
      {:kino, "~> 0.6.2"},
      {:ex_duck, "~> 0.1.1"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @github,
      source_ref: "v#{@version}",
      extras: [
        "README.md",
        "LICENSE",
      ],
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github
      }
    ]
  end
end
