defmodule FoodFavor.Log do
  @moduledoc """
  This module defines helper functions to create Logger events for the standard
  FoodFavor.Error.error() types.
  """

  require Logger

  alias FoodFavor.Error

  @type error_type :: :info | :warning | :error

  @spec report(Error.error(), error_type()) :: :ok
  def report({:error, %Error{} = error}, error_type) do
    log(error_type, error.message, %{errors: inspect(error.data)})
  end

  def report({:error, %Ecto.Changeset{} = changeset}, error_type) do
    errors = Error.errors_on(changeset)

    log(
      error_type,
      "Changeset #{Map.get(changeset.data, :__struct__, "")} #{changeset.action} error",
      %{errors: errors}
    )
  end

  defp log(:info, message, data), do: Logger.info(message, data)
  defp log(:warning, message, data), do: Logger.warning(message, data)
  defp log(:error, message, data), do: Logger.error(message, data)
end
