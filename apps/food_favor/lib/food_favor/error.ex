defmodule FoodFavor.Error do
  @moduledoc """
  Defines the common Error that will be used throughout the application in order to
  standardize the expected error response and handling. Also provides a build function
  to assist in error creation.
  """

  use TypedStruct

  alias __MODULE__

  typedstruct do
    @typedoc "A FoodFavor error struct"

    field :type, atom(), enforce: true
    field :message, String.t(), enforce: true
    field :data, map(), default: %{}
  end

  @type error() :: {:error, t()} | {:error, %Ecto.Changeset{}}

  @doc "Builds a standardized FoodFavor error tuple based on varied levels of input info"
  @spec build(atom(), String.t(), map()) :: {:error, t()}
  def build(type \\ :general_error, message, data \\ %{})

  def build(type, message, %{} = data) when is_binary(message),
    do: {:error, %Error{type: type, message: message, data: data}}

  @doc """
  A helper that transform changeset errors to a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  @spec errors_on(Ecto.Changeset.t()) :: map()
  def errors_on(%Ecto.Changeset{} = changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
