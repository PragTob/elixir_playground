defmodule ElixirPlayground.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_playground,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:assertions, "~> 0.10", only: :test},
      {:benchee, "~> 1.0", github: "bencheeorg/benchee", override: true},
      {:benchee_html, "~> 1.0", github: "bencheeorg/benchee_html"},
      {:credo, "~> 0.4"},
      {:ex_guard, "~> 1.3", only: :dev},
      {:mox, "~> 0.5.1"},
      {:plug, "~> 1.15"},
      {:stream_data, "~> 0.4", only: [:dev, :test]},
      {:jason, "~> 1.1"},
      {:timex, "~> 3.6"}
    ]
  end
end
