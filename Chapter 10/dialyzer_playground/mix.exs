defmodule DialyzerPlayground.Mixfile do
  use Mix.Project

  def project do
    [app: :dialyzer_playground,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:dialyxir, "~> 0.3", only: [:dev]}]
  end
end
