defmodule FoodFavor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodFavor.Repo,
      {DNSCluster, query: Application.get_env(:food_favor, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FoodFavor.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FoodFavor.Finch}
      # Start a worker by calling: FoodFavor.Worker.start_link(arg)
      # {FoodFavor.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: FoodFavor.Supervisor)
  end
end
