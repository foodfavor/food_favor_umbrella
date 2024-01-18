defmodule FoodFavor.PoductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodFavor.Poducts` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: "some category",
        description: "some description",
        title: "some title"
      })
      |> FoodFavor.Poducts.create_product()

    product
  end
end
