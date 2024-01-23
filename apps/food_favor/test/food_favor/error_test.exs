defmodule FoodFavor.ErrorTest do
  use FoodFavor.DataCase, async: true

  alias FoodFavor.Error

  describe "build/1/2/3" do
    test "builds a FoodFavor.Error.error.t() with a message" do
      assert {:error, %Error{type: :general_error, message: "test error message", data: %{}}} ==
               Error.build("test error message")
    end

    test "builds a FoodFavor.Error.error.t() with a type and message" do
      assert {:error, %Error{type: :invalid_input, message: "test error message", data: %{}}} ==
               Error.build(:invalid_input, "test error message")
    end

    test "builds a FoodFavor.Error.error.t() with a type, message, and data" do
      assert {:error,
              %Error{type: :invalid_input, message: "test error message", data: %{age: "invalid"}}} ==
               Error.build(:invalid_input, "test error message", %{age: "invalid"})
    end
  end

  describe "errors_on/1" do
    test "provides map of errors per field" do
      changeset =
        cast({%{}, %{age: :integer, data: :map}}, %{age: "invalid", data: :invalid}, [:age, :data])

      assert %{age: ["is invalid"], data: ["is invalid"]} == Error.errors_on(changeset)
    end

    test "returns empty map for valid changeset" do
      changeset =
        cast({%{}, %{age: :integer, data: :map}}, %{age: 1, data: %{a: 1}}, [:age, :data])

      assert %{} == Error.errors_on(changeset)
    end

    test "raises for non-changeset input" do
      assert_raise(FunctionClauseError, fn -> Error.errors_on(%{}) end)
    end
  end
end
