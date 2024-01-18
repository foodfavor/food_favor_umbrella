defmodule FoodFavor.PoductsTest do
  use FoodFavor.DataCase

  alias FoodFavor.Poducts

  describe "products" do
    alias FoodFavor.Poducts.Product

    import FoodFavor.PoductsFixtures

    @invalid_attrs %{description: nil, title: nil, category: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Poducts.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Poducts.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", title: "some title", category: "some category"}

      assert {:ok, %Product{} = product} = Poducts.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.title == "some title"
      assert product.category == "some category"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Poducts.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", category: "some updated category"}

      assert {:ok, %Product{} = product} = Poducts.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.title == "some updated title"
      assert product.category == "some updated category"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Poducts.update_product(product, @invalid_attrs)
      assert product == Poducts.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Poducts.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Poducts.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Poducts.change_product(product)
    end
  end
end
