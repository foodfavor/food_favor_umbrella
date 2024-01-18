defmodule FoodFavor.Poducts.Product do
  use FoodFavor.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :title, :string
    field :category, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :category, :description])
    |> validate_required([:title, :category, :description])
  end
end
