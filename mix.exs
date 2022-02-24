defmodule LiveUiKit.MixProject do
  use Mix.Project

  def project do
    [
      app: :live_ui_kit,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "LiveUIKit",
      description: "Collection of build components for Phoenix LiveView",
      homepage_url: "https://liveuikit.com",
      package: package()
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
      # {:phoenix, ">= 1.6.0 and < 1.7.0"},
      {:phoenix_live_view, ">= 0.17.0 and < 0.20.0"},
      {:phoenix_html, ">= 3.1.0 and < 4.0.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      maintainers: ["Andreas Eriksson"],
      links: %{
        "Github" => "https://github.com/liveuikit/live_ui_kit"
      },
    ]
  end
end
