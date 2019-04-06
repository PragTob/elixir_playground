defmodule ElixirPlayground.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_playground,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
      {:benchee,      "~> 0.14", github: "bencheeorg/benchee", override: true},
      {:benchee_html, "~> 0.1", github: "bencheeorg/benchee_html"},
      {:credo,        "~> 0.4"}
    ]
  end


end
