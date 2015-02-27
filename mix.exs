defmodule WebsocketsTermimal.Mixfile do
  use Mix.Project

  def project do
    [app: :websockets_termimal,
     version: "0.0.1",
     elixir: "~> 1.0",
     test_coverage: [tool: Coverex.Task],
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {WebsocketsTermimal, []},
     applications: [:phoenix, :cowboy, :logger, :porcelain]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.9.0"},
      {:cowboy, "~> 1.0"},
      {:porcelain, "~> 2.0"},
      {:coverex, github: "alfert/coverex"},
    ]
  end
end
