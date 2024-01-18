defmodule FoodFavor.Repo do
  use Ecto.Repo,
    otp_app: :food_favor,
    adapter: Ecto.Adapters.Postgres
end
