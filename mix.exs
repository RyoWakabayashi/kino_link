defmodule KinoLink.MixProject do
  use Mix.Project

  def project do
    [
      app: :kino_link,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A simple Kino for displaying rich links on Livebook.",
      source_url: "https://github.com/RyoWakabayashi/kino_link",
      homepage_url: "https://github.com/RyoWakabayashi/kino_link",
      package: package()
    ]
  end

  defp package do
    [
      maintainers: ["Ryo Wakabayashi"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/RyoWakabayashi/kino_link"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {KinoLink.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kino, "~> 0.14"},
      {:ogp, "~> 1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
